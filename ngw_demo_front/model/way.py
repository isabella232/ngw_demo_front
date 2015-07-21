import json
from logging import log, INFO
from datetime import datetime
from sqlalchemy import (
    Column,
    Integer,
    BigInteger,
    Text,
    Float
)
from geoalchemy2 import Geometry, shape
from utilites import GeoJsonMixin, DictionaryMixin
from rosavto.model import DBSession, Base
import geojson
from shapely.geometry import asShape

#osm2pgrouting 'ways' table
class Way(Base, DictionaryMixin, GeoJsonMixin):
    __tablename__ = 'ways'
    __table_args__ = {'schema': 'routing'}

    gid = Column(Integer, primary_key=True)
    class_id = Column(Integer)
    length = Column(Float)
    name = Column(Text)
    x1 = Column(Float)
    y1 = Column(Float)
    x2 = Column(Float)
    y2 = Column(Float)
    reverse_cost = Column(Float)
    rule = Column(Text)
    to_cost = Column(Float)
    maxspeed_forward = Column(Integer)
    maxspeed_backward = Column(Integer)
    osm_id = Column(BigInteger)
    priority = Column(Float)
    the_geom = Column(Geometry(spatial_index=True, srid=4326))
    source = Column(Integer, index=True)
    target = Column(Integer, index=True)

    @staticmethod
    def import_from_geojson_file(path_to_file):
        with open(path_to_file, 'r') as ways_geojson_file:
            db_session = DBSession()

            content = ways_geojson_file.read()
            json_file = json.loads(content)
            ways_geojson = geojson.loads(json.dumps(json_file['features']))

            for way in ways_geojson:
                properties = way['properties']
                properties['the_geom'] = shape.from_shape(asShape(way['geometry']), 4326)

                way_inst = Way()
                way_inst.set_fields_from_dict(properties)

                db_session.add(way_inst)
                db_session.flush()

    @staticmethod
    def export_to_geojson_file(path_to_file):
        with open(path_to_file, 'w') as ways_geojson_file:
            db_session = DBSession()

            count = db_session.query(Way).count()
            log(INFO, 'Total ways: %s' % count)

            log(INFO, 'Get data...')
            all_ways = db_session.query(Way, Way.the_geom.ST_AsGeoJSON()).all()  # limit(500)  # test

            #create json
            output_content = {
                'type': 'FeatureCollection',
                'generator': "rosavto-data",
                'copyright': "The data included in this document is from www.openstreetmap.org. The data is made available under ODbL.",
                'timestamp': datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S'),
                'features': []
            }

            handled = 0
            for way in all_ways:
                #create feat
                feature = {
                    'type': 'Feature',
                    'id': way[0].gid,
                    'geometry': json.loads(way[1]),
                    'properties': {}
                }
                #set attrs
                for prop, val in way[0].as_properties().items():
                    feature['properties'][prop] = val
                #add to collection
                output_content['features'].append(feature)
                #log
                handled += 1
                if handled % 1000 == 0:
                    log(INFO, 'Handled: %s' % handled)

            json.dump(output_content, ways_geojson_file, indent=4)