class ShapefileToGeojsonService
	require 'rgeo/shapefile'
	require 'rgeo/geo_json'
	require 'json'

	def initialize(shapefiles)
		@shapefiles = shapefiles
	end

	def perform
		save_shapefiles
		create_features_collection
		delete_temporary_files
		convert_to_geojson
	end

	private

	# Save shapefile to 'public/tmp' - Temporary measure - employ S3 for file storage
	def save_shapefiles
		@files = []

		@shapefiles.each do |file|
			shapefile = file.tempfile.read
			shapefile_name = file.original_filename
			@files << shapefile_name
			File.open(File.join(Rails.root, 'public', 'tmp', shapefile_name), 'wb') { |f| f.write shapefile }
		end
	end

	# Creatures features from each Shapefile object
	def create_features_collection
		features = []

		# Factory to set SRID - Is this being set correctly?
		factory = RGeo::Geographic.spherical_factory(:srid => 4326)

		# Open Shapefile with SRID factory
		RGeo::Shapefile::Reader.open(get_shp_file(@files), :factory => factory) do |file|

			file.each do |record|

				# Factory to create a RGeo 'feature' for each record
				factory = RGeo::GeoJSON::EntityFactory.instance

				# Feature object for each Shapefile record
				feature = factory.feature(
					record.geometry,
					record.index,
					record.attributes
				)

				features << feature
			end
		end

		@features_collection = add_features_to_collection(features)
	end

	# Clear shp files from public/tmp - Temporary measure - employ S3 for file storage
	def delete_temporary_files
		`rm -fr public/tmp/*`
	end

	# Encode 'Feature Collection' using GeoJSON Gem and convert to JSON
	def convert_to_geojson
		RGeo::GeoJSON.encode(@features_collection).to_json
	end

	# Get uploaded shp filename
	def get_shp_file(files)
		shp_extract = files.select{ |i| i[/\.shp$/] }
		shp_file = shp_extract[0]
		@path = Rails.root.join("public/tmp/#{shp_file}")
	end

	# Create a 'Features Collection' using 'Features'
	def add_features_to_collection(features)
		RGeo::GeoJSON::FeatureCollection.new(features)
	end

end