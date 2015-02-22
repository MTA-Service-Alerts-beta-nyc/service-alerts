require 'open-uri'
require 'date'

class Alert < ActiveRecord::Base

  def self.get_data

    puts "get data now"

    page = self.download_page
    lines = self.find_lines page

    lines.each do |line|
      puts self.line_data line
    end
  end

  private

    def self.download_page
      # For testing purposes, we get a saved serviceData file.
      return Nokogiri::HTML(open("../research/2015-02-22-08-42-01.xml"))

      url = "http://web.mta.info/status/serviceStatus.txt"
      begin
        # page = Nokogiri::HTML(open(url))
      rescue
        puts "Exception #{e}"
        puts "Unable to fetch #{url}"
      end
    end

    def self.find_lines page
      train_names = ["123", "456", "7", "ACE", "BDFM", "G", "JZ", "L", "NQR", "S", "SIR"]
      all_lines = page.css('line')
      all_lines.select do |line|
        train_names.include? line.css('name').inner_text
      end
    end

    def self.line_data line
      date = line.css('date').inner_text
      time = line.css('time').inner_text

      {
        name: line.css('name').inner_text,
        status: line.css('status').inner_text,
        date: "#{date} #{time}",
        text: self.clean_html_page line
      }
    end

    def self.clean_html_page line
      regex = /<\/*br\/*>|<\/*b>|<\/*i>|<\/*strong>|<\/*font.*?>|<\/*u>/
      line.css('text').inner_text.gsub(regex, '')
    end

end