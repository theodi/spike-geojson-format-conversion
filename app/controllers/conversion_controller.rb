class ConversionController < ApplicationController
	require 'rgeo/shapefile'
	require 'rgeo/geo_json'

  def index
  end

	def create
		# Get files from form upload
		files = []

		if !params[:files].nil?
		  params[:files].each{ |file|
		  	files << file.tempfile
		  }
		end
		puts files

		# NEXT STEPS: Provide RGeo with the .shp file that was uploaded
		# Ensure that RGeo is seeing the supplementary files

		# Factory to set SRID
		# Is this being set correctly?
		factory = RGeo::Geographic.spherical_factory(:srid => 4326)

		# Array for holding each created 'Feature' from the Shapefile
		features = []

		# Open Shapefile with SRID factory
		RGeo::Shapefile::Reader.open('stations.shp', :factory => factory) do |file|
			# This variable is not nescessary, just here for displaying process purposes
			@shapefile = file

			# Loop through loaded shapefile to get each 'record'
			file.each do |record|

				# Factory to create a RGeo 'feature' for each record
				factory = RGeo::GeoJSON::EntityFactory.instance

				# Feature object for each Shapefile record
				feature = factory.feature(
					record.geometry,
					record.index,
					record.attributes
				)

				# Push 'feature' to array
				features << feature
			end
		end

		# Create a 'Feature Collection'
		feature_collection = RGeo::GeoJSON::FeatureCollection.new(features)

		# Encode 'Feature Collection' using GeoJSON Gem and convert to JSON
		@geojson = RGeo::GeoJSON.encode(feature_collection).to_json
	end
end
