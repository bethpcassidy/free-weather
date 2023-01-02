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
    @forescast = forescast.find_by(id: params[:id])
    @forescast.high = params[:forescast][:high]
    @forescast.low = params[:forescast][:low]
    @forecast.average = params[:forecast][:average]
    @forecast.body = params[:forecast][:body]
    @forecast.image = params[:forecast][:image]
    @forecast.zipcode = params[:forecast][:zipcode]

    @forecast.save
    redirect_to "/forecasts"
  end
end
