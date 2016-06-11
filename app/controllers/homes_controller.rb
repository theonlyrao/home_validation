class HomesController < ApplicationController

  def new
    @home = Home.new
    @home.pictures.build
  end

  def create
    if Home.bad_address?(validation_params[:home] || {street: "", city: "", state: "", zip: ""})
      redirect_to validation_path
      flash[:error] = "Please check the address."
    elsif params[:home][:pictures_attributes].nil? || Picture.no_gps?(params[:home][:pictures_attributes]["0"][:picture])
      redirect_to validation_path
      flash[:error] = "Please make sure you have attached a picture with gps metadata."
    else
      validation = Creator.build(validation_params[:home], Picture.raw_picture)
      redirect_to validation_show_path(validation.id)
    end
  end

  private

  def validation_params
    params.require(:home).permit(home: [:address_1, :city, :state, :zip])
    # file = params["home"]["pictures_attributes"]["0"]["picture"].tempfile
    # gps = EXIFR::JPEG.new(file).gps
  end
end
