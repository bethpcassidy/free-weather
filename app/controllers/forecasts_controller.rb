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
    @forecast = Forecast.find_by(id: params[:id])
    render template: "forecasts/edit"
  end

  def update
    forecast = Forecast.find_by(id: params[:id])

    forecast.high = params[:high]
    forecast.low = params[:low]
    forecast.image = params[:image]
    forecast.body = params[:body]
    forecast.zipcode = params[:zipcode]

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
    forecast = Forecast.new(
      high: params[:forecast][:high],
      low: params[:forecast][:low],
      body: params[:forecast][:body],
      image: params[:forecast][:image],
      average: params[:forecast][:average],
      zipcode: params[:forecast][:zipcode],
    )
    forecast.save
    render json: forecast.as_json
  end
end
