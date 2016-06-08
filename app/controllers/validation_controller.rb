class ValidationController < ApplicationController

  def new
    @validation = Validation.new
    @home = Home.new
    @picture = Picture.new
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
