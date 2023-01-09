class ForecastsController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user
      @forecasts = Forecast.where(user_id: current_user.id)
    else
      render json: [], status: unauthorized
    end
  end

  def show
    @forecast = Forecast.find_by(id: params[:id])
    render :show
  end

  def edit
    @forecast = Forecast.find_by(id: params[:id])
    render template: "forecasts/edit"
  end

  def update
    forecast = Forecast.find_by(id: params[:id])
    id = forecast.id
    zip = forecast.zipcode
    forecast.destroy
    response = HTTP.get("https://geocode.maps.co/search?postalcode=#{zip}&country=US")
    response = response.parse
    #converts it to 2 decimal float longitude and lat values
    lat = response[0]["lat"]
    lon = response[0]["lon"]
    lat = lat.to_f
    lon = lon.to_f
    lat = lat.round(2)
    lon = lon.round(2)
    #names location
    name = response[0]["display_name"].split(",")
    #grab the weather data
    response2 = HTTP.get("https://api.open-meteo.com/v1/forecast?latitude=#{lat}&longitude=#{lon}&hourly=temperature_2m,precipitation&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_hours&current_weather=true&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timezone=auto")
    response2 = response2.parse
    #sort
    weatherhash = response2["current_weather"]
    now = weatherhash["temperature"]
    misctext = "Current Wind: #{weatherhash["windspeed"]}"
    #low high loop
    temp = response2["hourly"]["temperature_2m"]
    index = 0
    low = temp[0]
    high = temp[0]
    while index < temp.length
      if temp[index] < low
        low = temp[index]
      end
      index = index + 1
    end
    index = 0
    while index < temp.length
      if temp[index] > high
        high = temp[index]
      end
      index = index + 1
    end
    low = low.to_i
    high = high.to_i
    #forecast created
    #name[0]
    name = name[0]
    name = name.to_s
    forecast = Forecast.new(
      user_id: current_user.id,
      id: id,
      high: high,
      low: low,
      body: misctext,
      image: params[:image],
      average: now,
      zipcode: params[:zipcode],
      title: name,
    )
    forecast.save
    render json: forecast.as_json
  end

  def destroy
    forecast = Forecast.find_by(id: params[:id])
    forecast.destroy
    render json: { message: "forecast deleted" }
  end

  # def new
  #   @forecast = Forecast.new
  #   render template: "forecasts/new"
  # end

  def create
    #grabs geocode data for the zipcode
    zip = params[:zipcode]
    response = HTTP.get("https://geocode.maps.co/search?postalcode=#{zip}&country=US")
    response = response.parse
    #converts it to 2 decimal float longitude and lat values
    lat = response[0]["lat"]
    lon = response[0]["lon"]
    lat = lat.to_f
    lon = lon.to_f
    lat = lat.round(2)
    lon = lon.round(2)
    #names location
    name = response[0]["display_name"].split(",")
    #grab the weather data
    response2 = HTTP.get("https://api.open-meteo.com/v1/forecast?latitude=#{lat}&longitude=#{lon}&hourly=temperature_2m,precipitation&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_hours&current_weather=true&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timezone=auto")
    response2 = response2.parse
    #sort
    weatherhash = response2["current_weather"]
    now = weatherhash["temperature"]
    misctext = "Current Wind: #{weatherhash["windspeed"]}"
    #low high loop
    temp = response2["hourly"]["temperature_2m"]
    index = 0
    low = temp[0]
    high = temp[0]
    while index < temp.length
      if temp[index] < low
        low = temp[index]
      end
      index = index + 1
    end
    index = 0
    while index < temp.length
      if temp[index] > high
        high = temp[index]
      end
      index = index + 1
    end
    low = low.to_i
    high = high.to_i
    #forecast created
    #name[0]
    name = name[0]
    name = name.to_s
    forecast = Forecast.new(
      user_id: current_user.id,
      high: high,
      low: low,
      body: misctext,
      image: params[:image],
      average: now,
      zipcode: params[:zipcode],
      title: name,
    )
    forecast.save
    render json: forecast.as_json
  end
end
