class ConversionController < ApplicationController
	require 'rgeo/shapefile'
	require 'rgeo/geo_json'

  def index
		# Factory to set SRID
		# Is this being set correctly?
		factory = RGeo::Geographic.spherical_factory(:srid => 4326)

		# Array for holding each created 'Feature' from the Shapefile
		arr = []

		# Open Shapefile with SRID factory
		RGeo::Shapefile::Reader.open('stations.shp', :factory => factory) do |file|
			# This variable is not nescessary, just here for displaying process purposes
			@shapefile = file

			# Loop through loaded shapefile to get each 'record'
			file.each do |record|
				attributes = record.attributes

				# Factory to create a RGeo feature for each record to facilitate conversion to geoJSON
				factory = RGeo::GeoJSON::EntityFactory.instance

				# Feature object for each Shapefile record
				feature = factory.feature(
					record.geometry,
					record.index,
					{
						name: attributes['name'],
						marker_col: attributes['marker-col'],
						marker_sym: attributes['marker-sym'],
						line: attributes['line']
					}
				)

				# Push feature to array
				arr << feature
		  end
		end

		# Create a collection of features
		feature_collection = RGeo::GeoJSON::FeatureCollection.new(arr)

		# Encode feature collection using GeoJSON Gem and convert to JSON
		@geojson = RGeo::GeoJSON.encode(feature_collection).to_json
  end
end
