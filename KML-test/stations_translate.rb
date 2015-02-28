require 'nokogiri'
require 'pry'

stations_kml = File.open('subway_stations.kml')
# parse with nokogiri
stations_xml_ns = Nokogiri::XML(stations_kml)
# parsed data into a nodeset of each station
stations_ns = stations_xml_ns.css('Placemark')

# longitude = stations_ns[0].css('longitude').text
# latitutde = stations_ns[0].css('latitude').text
# description = Nokogiri::HTML(stations_ns[0].css('description').text)
# name = description.css('span')[1].text
# lines = description.css('span')[5].text.split("-")

binding.pry
