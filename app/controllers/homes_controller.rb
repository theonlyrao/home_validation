class HomesController < ApplicationController

  def new
    @home = Home.new
    @home.pictures.build
  end

  def create
    if params[:home][:pictures_attributes].nil? || Home.bad_address?(validation_params[:home] || {street: "", city: "", state: "", zip: ""})
      render :new
      flash.now[:error] = "Please check the address."
    elsif Picture.no_gps?(params[:home][:pictures_attributes]["0"][:picture])
      render :new
      flash.now[:error] = "Please make sure your picture has gps metadata."
    else
      raw_picture = params[:home][:pictures_attributes]["0"][:picture]
      validation = Creator.build(validation_params[:home], raw_picture)
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
