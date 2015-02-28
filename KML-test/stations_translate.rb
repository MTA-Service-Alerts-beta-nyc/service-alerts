require 'nokogiri'
require 'pry'

stations_kml = File.open('subway_stations.kml')
# parse with nokogiri
stations_xml_ns = Nokogiri::XML(stations_kml)
# parsed data into a nodeset of each station
stations_ns = stations_xml_ns.css('Placemark')

binding.pry
