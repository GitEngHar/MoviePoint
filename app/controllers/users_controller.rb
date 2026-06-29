class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find_by(user_id: params[:id])
    render json: user
  end

  def create
    user = User.create!(user_params)
    render json: user, status: :created
  end


  def update
    user = User.find_by_user_id(params[:id])
    if user.update(user_params)
      render json: user, status: :accepted
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
  private
  def user_params
    params.permit(
    :user_id,
    :name,
    :age
    )
  end
end
