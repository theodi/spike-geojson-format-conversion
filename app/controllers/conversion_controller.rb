class ConversionController < ApplicationController

  def index
  end

	def create
		shapefiles = params[:files]
		@geojson = ShapefileToGeojsonService.new(shapefiles).perform
	end

end
