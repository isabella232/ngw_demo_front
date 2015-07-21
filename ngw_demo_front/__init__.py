from pyramid.config import Configurator
from sqlalchemy import engine_from_config

from ngw_demo_front.model import Base, DBSession


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    # engine = engine_from_config(settings, 'sqlalchemy.')
    # DBSession.configure(bind=engine)
    # Base.metadata.bind = engine
    config = Configurator(settings=settings)
    config.include('pyramid_mako')
    config.include("cornice")
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('index', '/')
    config.add_route('widgets_list', '/widgets/list')
    config.add_route('wms', '/wms')
    config.add_route('base_layers', '/base_layers')
    config.add_route('layers', '/layers')

    config.add_route('layer', '/layer')
    config.add_route('marker', '/marker')
    config.add_route('realtime', '/realtime')
    config.add_route('attributes', '/attributes')
    config.add_route('attributes_html', '/gis/card')
    config.add_route('incident', '/incident')
    config.add_route('center', '/center')
    config.add_route('routing_sample', '/routing_sample')
    config.add_route('routing_chainage_sample', '/routing_chainage_sample')
    config.add_route('code', '/code')
    config.add_route('time', '/time')
    config.add_route('clusters', '/clusters')
    config.add_route('sensors', '/sensors')
    config.add_route('object_selector', '/object_selector')
    config.add_route('repairs', '/repairs')
    config.add_route('repairs_status', '/repairs/status')

    # proxies url
    config.add_route('proxy_ngw', '/ngw/*target_url')
    config.add_route('proxy_cit', '/cit/*target_url')
    
    # routing url 
    config.add_route('routing', '/routing')
    config.add_route('simple_routing', '/simple_routing')

    config.scan()
    return config.make_wsgi_app()
