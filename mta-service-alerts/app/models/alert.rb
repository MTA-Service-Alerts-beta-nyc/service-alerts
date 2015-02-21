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
      url = "http://web.mta.info/status/serviceStatus.txt"
      begin
        page = Nokogiri::HTML(open(url))
      rescue
        puts "Exception #{e}"
        puts "Unable to fetch #{url}"
      end
    end

    def self.find_lines page
      page.css('line')
    end

    def self.line_data line
      date = line.css('date').inner_text
      time = line.css('time').inner_text

      {
        name: line.css('name').inner_text,
        status: line.css('status').inner_text,
        date: "#{date} #{time}"
      }
    end

end