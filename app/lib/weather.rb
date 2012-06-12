require 'nokogiri'
require 'open-uri'

module Weather
  def self.forecast(city, state)
    api_call = URI.encode "#{WarpedTour.settings.weather_api}?weather=#{city},#{state}"
    doc = Nokogiri::XML( open api_call )
    current = doc.at_xpath('//current_conditions')
    {
      :temp      => current.at_xpath('//temp_f')['data'],
      :condition => current.at_xpath('//condition')['data'],
      :humidity  => current.at_xpath('//humidity')['data'],
      :wind      => current.at_xpath('//wind_condition')['data'], 
      :img       => 'http://www.google.com' << current.at_xpath('//icon')['data']
    }
  end
end