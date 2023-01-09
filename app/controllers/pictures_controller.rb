class PicturesController < ApplicationController
  def show
    @picture = Picture.find_by(id: params[:id])
    render :show
  end
end
