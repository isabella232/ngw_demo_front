<%inherit file="master.mako"/>

<%block name="title">Аттрибуты</%block>

<div class="code-description">
    <p>Для получения сведений о атрибутах объекта кликните по объекту на карте. Если в области клика будет несколько объектов - выберите нужный.</p>
    <p>Код с комментариями <a href="${request.route_url('code') + '#attributes'}">здесь</a></p>
</div>

<div id="map"></div>
<div id="attributes">Здесь будут атрибуты выбранного обекта</div>

<%block name="inlineScripts">
    require([
        'rosavto/Map',
        'rosavto/LayersInfo',
        'rosavto/MapIdentify',
        'rosavto/AttributeGetter',
        'rosavto/AttributesServiceFacade',
        'rosavto/NgwServiceFacade',
        'dojo/domReady!'],

    function (Map, LayersInfo, MapIdentify, AttributeGetter, AttributesServiceFacade, NgwServiceFacade) {
        var ngwUrlBase = 'http://demo.nextgis.ru/ngw_rosavto/',
            proxyUrl = application_root + '/proxy',
            ngwServiceFacade = new NgwServiceFacade(ngwUrlBase, {proxy: proxyUrl}),
            attributesBaseUrl = 'http://zulu.centre-it.com:7040/',
            attributesServiceFacade = new AttributesServiceFacade(attributesBaseUrl, {proxy: proxyUrl}),
            map = new Map('map', {
                center: [55.529, 37.584],
                zoom: 7,
                zoomControl: true,
                legend: true
            }),
            layersInfo,
            mapIdentify,
            attributeGetter,
            layersInfoSettings = {
                ngwServiceFacade: ngwServiceFacade
            },
            mapIdentifySettings = {
                ngwServiceFacade: ngwServiceFacade,
                fieldIdentify: 'uniq_uid'
            },
            attributeGetterSettings = {
                ngwServiceFacade: ngwServiceFacade,
                attributesServiceFacade: attributesServiceFacade,
                style: {
                    fill: false,
                    color: '#FF0000',
                    weight: 2
                },
                domSelector: '#attributes',
                urlBuilder: function (id) {
                    return {
                        url: application_root + '/proxy',
                        settings: {
                            handleAs: 'json',
                            method: 'POST',
                            data: {
                                url: 'http://zulu.centre-it.com:7040/monitoring-web/gis/card?guid=' + id
                            }
                        }
                    }
                }
            };

        map.addNgwTileLayer('Тестовые дороги', ngwUrlBase, 8);
        map.addNgwTileLayer('Регионы', ngwUrlBase, 7);
        map.addNgwTileLayer('Нормативные участки дорог', ngwUrlBase, 10);
        map.addNgwTileLayer('Участки подрядных организаций', ngwUrlBase, 9);

        layersInfo = new LayersInfo(ngwServiceFacade);

        mapIdentify = new MapIdentify({
            map: map,
            ngwServiceFacade: ngwServiceFacade,
            layersInfo: layersInfo,
            fieldIdentify: 'uniq_uid'
        });
        mapIdentify.on();

        attributeGetter = new AttributeGetter({
            map: map,
            ngwServiceFacade: ngwServiceFacade,
            attributesServiceFacade: attributesServiceFacade,
            domSelector: '#attributes',
            mapIdentify: mapIdentify
        });
    });
</%block>