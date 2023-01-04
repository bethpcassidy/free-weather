class LocationsController < ApplicationController
  def create
    # zip = 11216
    # response = HTTP.get "https://geocode.maps.co/search?postalcode=#{zip}&country=US"
    # response = response.parse(:json)

    # location = Location.new(
    #   zipcode: zip,
    #   name: response["display_name"],
    #   longitude: response["lon"],
    #   latitude: response["lat"],
    # )
    # location.save
    # render json: location.as_json

    location = Location.new(
      zipcode: zip,
      name: params[:location][:zipcode],
      longitude: params[:location][:name],
      latitude: response[:location][:latitude],
      longitude: response[:location][:longitude],
    )
    location.save
    render json: location.as_json
  end

  def index
    @location = Location.all
    render :index
  end

  def show
    @location = Location.find_by(id: params[:id])
    render :show
  end

  def edit
    @location = Location.find_by(id: params[:id])
    render template: "locations/edit"
  end
end
