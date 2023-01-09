class UsersController < ApplicationController
  before_action :authenticate_user, except: [:index, :create, :show]

  def new
    @user = User.new
    render template: "users/new"
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
    )
    if @user.save
      render json: @user.as_json
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end
end
