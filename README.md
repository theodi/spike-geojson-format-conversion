# Prototyping a Shapefile to geoJSON conversion tool

### About
This is a spike for Shapefile format conversion

### Process
1) Add to Gemfile `rgeo`, `rgeo-shapefile`, `rgeo-geojson`, `dbf` and `leaflet-rails`
2) Run `bundle install`

### Elements
- Conversion service - Converts Shapefile to geoJSON ('app/services')
- Controller - Calls conversion service and provides prettified geoJSON to view
- View - Displays mapped geoJSON (leaflet.js) and prettified geoJSON
- Javascript - Minimal client side validation on upload form | setup map and ingest geoJSON ('app/assets/javascripts/conversion.js')
- CSS - Base styling for application ('app/assets/stylesheets/application.css')

### Notes
- Uploaded Shapefiles are saved locally to ('public/tmp'), They are wiped by the service after conversion to geoJSON
- geoJSON is saved to a file in ('public/geojson/tmp.geojson'), this is written over each time the tool is used
- The two notes above are temporary measures, AWS S3 and a psql database will be employed when migrated to Octopub
- Client side validation - .shp files must be present to submit - this validation needs consideration in the context of Octopub.
