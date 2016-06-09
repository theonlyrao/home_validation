class HomesController < ApplicationController

  def new
    @home = Home.new
    @home.pictures.build
  end

  def create
    validation = Creator.build(validation_params[:home], validation_params[:pictures_attributes]["0"])
    redirect_to validation_show_path(validation.id)
  end

  private

  def validation_params
    params.require(:home).permit(home: [:address_1, :city, :state, :zip], pictures_attributes: [:lat, :long] )
  end
end
