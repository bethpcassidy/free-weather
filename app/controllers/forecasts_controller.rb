class ForecastsController < ApplicationController
  def index
    @forecasts = Forecast.all
    render json: @forecasts
  end

  def show
    @forecast = Forecast.find_by(id: params[:id])
    render json: @forecast
  end
end
