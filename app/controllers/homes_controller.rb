class HomesController < ApplicationController

  def new
    @home = Home.new
    @home.pictures.build
  end

  def create
    @home = Home.create(validation_params[:home])
    @picture = Picture.create(lat: validation_params[:pictures_attributes]["0"]["lat"], long: validation_params[:pictures_attributes]["0"]["long"])
    @picture.homes << @home
    @validation = Validation.create(home_id: @home.id, validated: true)
    redirect_to validation_show_path(@validation.id)
  end

  private

  def validation_params
    params.require(:home).permit(home: [:address_1, :city, :state, :zip], pictures_attributes: [:lat, :long] )
  end
end
