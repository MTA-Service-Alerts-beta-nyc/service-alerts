require 'open-uri'
require 'date'
require 'pry'

class Alert < ActiveRecord::Base

  def self.get_data

    puts "get data now"

    page = self.download_page
    lines = self.find_lines page

    lines.each do |line|
      line_data = self.line_data line

      if self.alert_exists? line_data
        puts line_data
        #binding.pry
        current_time = self.convert_time(page.css('timestamp').inner_text)
        self.update_database line_data, current_time
      end
    end
  end

  private

    def self.alert_exists? data
      data[:status] != "GOOD SERVICE"
    end

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

      result = {
        name: line.css('name').inner_text,
        status: line.css('status').inner_text,
        start_time: "#{date} #{time}",
        text: self.clean_html_page(line)
      }

      unless result[:start_time].blank?
        result[:start_time] = self.convert_time(result[:start_time])
      end

      return result
    end

    def self.clean_html_page line
      regex = /<\/*br\/*>|<\/*b>|<\/*i>|<\/*strong>|<\/*font.*?>|<\/*u>/
      line.css('text').inner_text.gsub(regex, '').gsub('&nbsp;', '')
          .gsub('Posted: ', '').gsub(/\s{2,}/, ' ')
    end

    def self.update_database data, current_time
      line_active_alert = Alert.find_by active: true, name: data[:name]

      if line_active_alert

        if self.same_alert line_active_alert, data
          self.update_end_time line_active_alert, current_time
          # Update the active_until time to current time
        else
          self.set_alert_inactive line_active_alert
          self.create_data data
        end

      else 
        self.create_data data
      end


    end

    def self.same_alert line_active_alert, data
      # binding.pry
        line_active_alert[:status] == data[:status] &&
        line_active_alert[:text] == data[:text]
    end

    def self.set_alert_inactive alert
      alert[:active] = false
      alert.save
    end

    def self.create_data data
      # binding.pry
      alert = Alert.new
      alert[:name] = data[:name]
      alert[:status] = data[:status]
      alert[:start_time] = data[:start_time]
      alert[:end_time] = data[:start_time]
      alert[:text] = data[:text]
      alert[:active] = true

      alert.save
    end

    def self.convert_time time_string
      time_string = time_string.gsub(/\s{2,}/, ' ')
                               .gsub(" PM","PM")
                               .gsub(" AM","AM")
                               .gsub(/0(\d\/)/, '\1')
                               .gsub(/ (\d:)/, ' 0\1')

      puts '#####################'
      puts "_#{time_string}_"
      DateTime.strptime(time_string, "%m/%d/%Y %I:%M%p")
    end

    def self.update_end_time record, current_time
      record[:end_time] = current_time
      record.save
    end

end
