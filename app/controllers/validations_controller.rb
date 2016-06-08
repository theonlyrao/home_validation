class ValidationsController < ApplicationController

  def show
    @validation = Validation.find(params[:id])
  end
  
  def new
    @validation = Validation.new
    @validation.build_home
    @validation.pictures.build

  end

  def create
    @home = Home.new(validation_params[:address])
    @picture = Picture.new(picture: validation_params[:picture], home_id: @home.id)
    current_user = User.new
    @validation = Validation.new(home_id: @home.id, user_id: current_user.id)
    byebug
  end

  private

  def validation_params
    params.permit(:address_1, :state, :zip, :picture)
  end
  
end
