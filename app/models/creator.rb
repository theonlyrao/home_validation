module Creator

  def self.build(raw_home, raw_picture, current_user)
    @user = current_user
    home = self.make_home(raw_home)
    self.make_picture(home, raw_picture)
    validation = self.make_validation(home)
  end

  def self.make_home(raw_home)
    Home.build_home(raw_home)
  end

  def self.make_picture(home, raw_picture)
    lat = Picture.gps.latitude
    long = Picture.gps.longitude
    #picture = Picture.create(picture: raw_picture, lat: lat, long: long, picture_file_name: "http://home-validation.s3.amazonaws.com/#{raw_picture.original_filename}")
    picture = Picture.create(picture: raw_picture, lat: lat, long: long)
    picture.homes << home
  end

  def self.make_validation(home)
    if @user.nil?
      validation = Validation.create(home_id: home.id)
    else
      validation = Validation.create(home_id: home.id, user_id: @user.id)
    end
    validation.validated = validation.check_gps
    validation.save
    validation
  end
  
end
