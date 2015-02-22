require 'open-uri'
require 'date'

class Alert < ActiveRecord::Base

  def self.get_data

    puts "get data now"

    page = self.download_page
    lines = self.find_lines page

    lines.each do |line|
      line_data = self.line_data line
      self.save_data line_data
    end
  end

  private

    def self.download_page
      # For testing purposes, we get a saved serviceData file.
      # return Nokogiri::HTML(open("../research/2015-02-22-08-42-01.xml"))

      url = "http://web.mta.info/status/serviceStatus.txt"
      begin
        page = Nokogiri::HTML(open(url))
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
        text: self.clean_html_page(line),
        active: true
      }
    end

    def self.clean_html_page line
      regex = /<\/*br\/*>|<\/*b>|<\/*i>|<\/*strong>|<\/*font.*?>|<\/*u>/
      line.css('text').inner_text.gsub(regex, '')
    end

    def self.in_database? data
      line_active_alert = Article.find_by active: true, name: data[:name]

      if self.same_alert line_active_record, data

        # Update the active_until time to current time
      else
        self.set_alert_inactive
        self.save_data data
      end
    end

    def self.same_alert record, data
      line_active_alert[:status] == data[:status] &&
        line_active_alert[:text] == data[:text]
    end

    def self.set_alert_inactive alert
      alert[:active] = false
      alert.save
    end

    def self.save_data data
      alert = Alert.new
      alert[:name] = data[:name]
      alert[:status] = data[:status]
      alert[:date] = data[:date]
      alert.save
    end

end