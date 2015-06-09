import os

from setuptools import setup, find_packages

here = os.path.abspath(os.path.dirname(__file__))
README = open(os.path.join(here, 'README.md')).read()
CHANGES = open(os.path.join(here, 'CHANGES.txt')).read()

requires = [
    'pyramid_mako',
    'pyramid',
    'SQLAlchemy',
    'psycopg2',
    'transaction',
    'pyramid_tm',
    'pyramid_debugtoolbar',
    'zope.sqlalchemy',
    'waitress',
    'geojson',
    'shapely',
    'geoalchemy2',
    'flup',
    'tornado',
    'sockjs-tornado'
]

setup(name='rosavto',
      version='0.0',
      description='rosavto',
      long_description=README + '\n\n' + CHANGES,
      classifiers=[
          "Programming Language :: Python",
          "Framework :: Pyramid",
          "Topic :: Internet :: WWW/HTTP",
          "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
      ],
      author='NextGIS',
      author_email='info@nextgis.ru',
      url='https://github.com/nextgis/ngw_demo_front',
      keywords='web wsgi pylons pyramid widgets NextGIS Web',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      test_suite='rosavto',
      install_requires=requires,
      entry_points="""\
      [paste.app_factory]
      main = rosavto:main
      [console_scripts]
      initialize_rosavto_db = rosavto.initializedb.initializedb:main
      ways_exporter = rosavto.initializedb.ways_exporter:main
      """,
      )
