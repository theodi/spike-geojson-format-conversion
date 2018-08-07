class ConversionController < ApplicationController
	require 'rgeo/shapefile'
	require 'rgeo/geo_json'
	require 'json'

  def index
  end

	def create
		files = []
		# Get files from form upload and write to '/public/tmp' directory
		if !params[:files].nil?
		  params[:files].each{ |file|
		  	shapefile = file.tempfile.read
				filename = file.original_filename
				files << filename
				File.open(File.join(Rails.root, 'public', 'tmp', filename), 'wb') { |f| f.write shapefile }
		  }
		end

		# Get uploaded shp filename for passing to RGeo
		shp_extract = files.select{ |i| i[/\.shp$/] }
		shp_file = shp_extract[0]
		path = Rails.root.join("public/tmp/#{shp_file}")

		# Factory to set SRID - Is this being set correctly?
		factory = RGeo::Geographic.spherical_factory(:srid => 4326)

		# Array for holding each created 'Feature' from the Shapefile
		features = []

		# Open Shapefile with SRID factory
		RGeo::Shapefile::Reader.open(path, :factory => factory) do |file|

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

		# Uncomment to render as JSON
		# render json: JSON.pretty_generate(@geojson)

		# Clear shp files from public/tmp
		# S3 should be employed here for file storage
		`rm -fr public/tmp/*`
	end

end
