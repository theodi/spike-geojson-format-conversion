class ConversionController < ApplicationController
	require 'rgeo/shapefile'

  def index
		RGeo::Shapefile::Reader.open('stations.shp') do |file|
			@file = file
		end
  end
end
