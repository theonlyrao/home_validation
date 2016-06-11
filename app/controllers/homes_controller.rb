class HomesController < ApplicationController

  def new
    @home = Home.new
    @home.pictures.build
  end

  def create
    raw_picture = params[:home][:pictures_attributes]["0"][:picture]
    if Home.bad_address?(validation_params[:home] || {street: "", city: "", state: "", zip: ""})
      render :new
      flash.now[:error] = "Please check the address and make sure your picture has gps metadata."
    else
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
