class ForecastsController < ApplicationController
  def index
    @forecasts = Forecast.all
    render :index
  end

  def show
    @forecast = Forecast.find_by(id: params[:id])
    render :show
  end

  def edit
    @forescast = Forescast.find_by(id: params[:id])
    render template: "forescasts/edit"
  end

  def update
    forescast = Forecast.find_by(id: params[:id])

    forescast.high = params["high"]
    forescast.low = params["low"]
    forecast.body = params["body"]
    forecast.image = params[:image]
    forecasts.zipcode = params[:zipcode]

    @forecast.save
    render json: @forecast.as_json
  end
end
