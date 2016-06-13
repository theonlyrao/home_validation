class HomesController < ApplicationController

  def new
    @home = Home.new
    @home.pictures.build
  end

  def create
    if Home.bad_address?(validation_params[:home])
      redirect_to validation_path
      flash[:error] = "Please check the address."
    elsif params[:home][:pictures_attributes].nil? || Picture.no_gps?(params[:home][:pictures_attributes]["0"][:picture])
      redirect_to validation_path
      flash[:error] = "Please make sure you have attached a picture with gps metadata."
    else
      validation = Creator.build(validation_params[:home], Picture.raw_picture, current_user)
      redirect_to validation_show_path(validation.id)
    end
  end

  private

  def validation_params
    params.require(:home).permit(home: [:address, :city, :state, :zip])
  end
end
