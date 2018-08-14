source 'https://rubygems.org'

ruby "2.4.2"

gem 'rails', '5.0.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# RGeo is a geospatial data library for Ruby
gem 'rgeo'
# RGeo module that provides parsing and analyzing of shapefiles, exposes the data to you as RGeo geometric objects
gem 'rgeo-shapefile'
# RGeo module that provides GeoJSON encoding and decoding
gem 'rgeo-geojson'
# RGeo module that facilitates the reading of dBASE attributes in shapefiles
gem 'dbf'
# Leaflet.js for geoJSON mapping
gem 'leaflet-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 5.0.4'
  gem 'coffee-rails', '~> 4.1.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '>= 4.3.3'

group :production do
  gem 'rails_12factor'
  gem 'puma'
end
