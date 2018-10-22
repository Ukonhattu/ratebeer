class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      raise "APIX_APIKEY env variable not defined" if ENV['APIX_APIKEY'].nil?

      key = ENV['APIX_APIKEY']
      url = "http://api.apixu.com/v1/current.json?key=#{key}&q="
      response = HTTParty.get "#{url}#{ERB::Util.url_encode(params[:city])}"
      @weather = response.parsed_response
      render :index
    end
  end

  def show
    raise "BEERMAPPING_APIKEY env variable not defined" if ENV['BEERMAPPING_APIKEY'].nil?

    key = ENV['BEERMAPPING_APIKEY']
    url = "http://beermapping.com/webservice/locquery/#{key}/"
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(params[:id])}"
    place = response.parsed_response["bmp_locations"]["location"]
    @place = Place.new(place)
  end

  def self.key
  end
end
