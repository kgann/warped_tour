module TourDatesController
  def self.registered app
    app.get '/' do
      params[:limit] ||= 5
      @dates = TourDate.new.get_dates params[:limit].to_i
      haml :index
    end
  end
end