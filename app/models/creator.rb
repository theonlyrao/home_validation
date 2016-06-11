module Creator

  def self.build(raw_home, raw_picture)
    home = self.make_home(raw_home)
    self.make_picture(home, raw_picture)
    validation = self.make_validation(home)
  end

  def self.make_home(raw_home)
    home = Home.create(raw_home)
    home.create_lat_and_long
    home
  end

  def self.make_picture(home, raw_picture)
    file = raw_picture.tempfile
    name = home.id.to_s + "-" + raw_picture.original_filename
    gps = EXIFR::JPEG.new(file).gps
    picture = Picture.create(picture: raw_picture, lat: gps.latitude, long: gps.longitude, picture_file_name: "http://home-validation.s3.amazonaws.com/#{raw_picture.original_filename}")
    picture.homes << home                              
  end

  def self.make_validation(home)
    validation = Validation.create(home_id: home.id)
    validation.validated = validation.check_gps
    validation.save
    validation
  end
  
end



