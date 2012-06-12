require 'nokogiri'
require 'open-uri'
require 'json'
require 'date'

class TourDate

  def initialize
    @today = Date.today
  end

  def get_dates(limit=5)
    tour_dates.first(limit).each_with_object([]) do |event, data|
      data << event.merge( Weather::forecast event[:city], event[:state] )
    end
  end

  private
    def tour_dates
      doc = Nokogiri::HTML( open URI.encode(WarpedTour.settings.tour_dates_url) )
      doc.css('tr.event-row').each_with_object([]) do |event, dates|
        month, day = event.at_css('.date a').text.split
        city, state = event.at_css('.location').inner_html.split('<br>')[-1].split(',')
        if Date.new(@today.year, Date::ABBR_MONTHNAMES.index(month), day.to_i) >= @today
          dates << {
            :month => month,
            :day   => day.to_i,
            :city  => city.strip,
            :state => state.strip
          }
        end
      end
    end
end