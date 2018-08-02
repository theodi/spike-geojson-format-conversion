class ConversionController < ApplicationController
	require 'rgeo/shapefile'
	require 'rgeo/geo_json'

  def index
		RGeo::Shapefile::Reader.open('stations.shp') do |file|
			@shapefile = file
			file.each do |record|
		    puts "Record number #{record.index}:"
		    puts "Geometry: #{record.geometry.as_text}"
		    puts "Attributes: #{record.attributes.inspect}"
		  end
		  file.rewind
		  record = file.next
		  puts "First record geometry was: #{record.index}"
		end
  end
end
