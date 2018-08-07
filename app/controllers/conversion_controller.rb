class ConversionController < ApplicationController

  def index
  end

	def new
		@title = 'Shapefile to geoJSON converter'
	end

	def create
		shapefiles = params[:files]
		@geojson = ShapefileToGeojsonService.new(shapefiles).perform
		render :show
	end

end
