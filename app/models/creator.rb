module Creator

  def self.build(raw_home, raw_picture)
    home = self.make_home(raw_home)
    self.make_picture(home, raw_picture)
    validation = self.make_validation(home)
  end

  def self.make_home(raw_home)
    # home = Home.new(raw_home)
    # home.create_lat_and_long
    # home.save
    # home
    Home.build_home(raw_home)
  end

  def self.make_picture(home, raw_picture)
    lat = Picture.gps.latitude
    long = Picture.gps.longitude
    picture = Picture.create(picture: raw_picture, lat: lat, long: long, picture_file_name: "http://home-validation.s3.amazonaws.com/#{raw_picture.original_filename}")
    picture.homes << home
  end

  def self.make_validation(home)
    validation = Validation.create(home_id: home.id)
    validation.validated = validation.check_gps
    validation.save
    validation
  end
  
end



