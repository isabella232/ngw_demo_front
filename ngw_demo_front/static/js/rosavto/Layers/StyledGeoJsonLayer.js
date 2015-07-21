define([
    'dojo/_base/declare',
    'leaflet/leaflet'
], function (declare) {
    return declare('rosavto.StyledGeoJsonLayer', [L.GeoJSON], {

        constructor: function () {
            var self = this;

            this.layersById = {};

            this.options.pointToLayer = function (feature, latlng) {
                return self.pointToLayer(feature, latlng);
            };

            this.options.onEachFeature = function (feature, layer) {
                self.onEachFeature(feature, layer);
            };

            if (!this.options.fieldStyleType) {
                this.options.fieldStyleType = 'type';
            }
        },

        addObject: function (geoJson, type, id) {
            var layer;

            geoJson.properties.__type = type;
            geoJson.properties.__id = id;

            layer = this.addData(geoJson);

            if (this.options.styles[type]) {
                this.setPosition(layer, this.options.styles[type]['position']);
            }

            return layer;
        },

        addObjectByProperties: function (geoJson, typeField, idField) {
            if (!geoJson.properties[typeField] || !geoJson.properties[idField]) {
                return false;
            }

            return this.addObject(geoJson, geoJson.properties[typeField], geoJson.properties[idField]);
        },

        addObjectByDefaultProperties: function (geoJson) {
            var options = this.options;

            if (!options.fields || !options.fields['type'] || !options.fields['id'] || !geoJson.properties[options.fields.id]) {
                return false;
            }

            return this.addObject(geoJson, geoJson.properties[options.fields.type], geoJson.properties[options.fields.id]);
        },

        removeObject: function (id) {
            if (this.layersById[id]) {
                this.removeLayer(this.layersById[id]);
                delete this.layersById[id];
            }
        },

        pointToLayer: function (feature, latlng) {
            if (!feature.properties.__type) {
                return new L.Marker(latlng);
            }

            var type = feature.properties.__type,
                style,
                pointStyle;

            if (!this.options.styles[type]) {
                console.log('StyledGeoJsonLayer: "' + type + '" type is not found into styles');
                return new L.Marker(latlng);
            }

            style = this.options.styles[type];

            pointStyle = style.point || null;
            if (pointStyle) {
                if (!pointStyle.type) {
                    throw new Error('Point style is not contained "type" property :' + pointStyle);
                }
                if (pointStyle.type === 'icon') {
                    return L.marker(latlng, {
                        icon: L.icon(pointStyle)
                    });
                } else if (pointStyle.type === 'circle' && pointStyle.radius && pointStyle.style) {
                    return L.circle(latlng, pointStyle.radius, pointStyle.style);
                } else if (pointStyle.type === 'div') {
                    return L.marker(latlng, {
                        icon: L.divIcon(pointStyle)
                    });
                }
            } else {
                return new L.Marker(latlng);
            }
        },

        onEachFeature: function (feature, layer) {
            var self = this,
                type,
                id;

            if (this.options.callbackClick) {
                layer.on('click', function () {
                    self.options.callbackClick.call(this, feature.properties.__id, feature);
                });
            }

            if (feature.geometry.type !== 'Point' && feature.properties.__type) {
                type = feature.properties.__type;

                if (this.options.styles[type] && this.options.styles[type].line) {
                    layer.setStyle(this.options.styles[type].line);
                }
            }

            if (feature.properties.__id) {
                id = feature.properties.__id;
                this.removeObject(id);
                this.layersById[id] = layer;
            }
        },

        setPosition: function (layer, position) {
            if (position) {

                if (!this._map._panes.overlayPane.firstChild) {
                    return;
                }

                switch (position) {
                    case 'front':
                        return layer.bringToFront();
                        break;
                    case 'back':
                        return layer.bringToBack();
                        break;
                }
            }
        },

        addType: function (type, style) {
            if (style['point'] || style['line']) {
                this.options.styles[type] = style;
            } else {
                throw new Error('StyledGeoJsonLayer: added style is not contained "point" or "line" property');
            }

            return this;
        },

        clearTypes: function () {
            this.options.styles = {};
            return this;
        }
    });
});