require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/config_file'

class WarpedTour < Sinatra::Base
  require_relative 'controllers/tour_dates_controller'
  require_relative 'models/tour_date'
  require_relative 'lib/weather'

  register Sinatra::ConfigFile
  configure do
    set :root, File.expand_path('../', File.dirname(__FILE__))
    set :views, "#{settings.root}/app/views"
    set :public_folder, "#{settings.root}/public"
    config_file "#{settings.root}/config/warped_tour.yml"
  end

  # get '/'
  register TourDatesController
end