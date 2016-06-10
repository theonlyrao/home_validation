module Creator

  def self.build(raw_home, picture_gps)
    home = self.make_home(raw_home)
    self.make_picture(home, picture_gps)
    validation = self.make_validation(home)
  end

  def self.make_home(raw_home)
    home = Home.create(raw_home)
    home.create_lat_and_long
    home
  end

  def self.make_picture(home, gps)
    byebug
    picture = Picture.create(lat: gps["lat"], long: gps["long"])
    picture.homes << home                              
  end

  def self.make_validation(home)
    validation = Validation.create(home_id: home.id)
    validation.validated = validation.check_gps
    validation.save
    validation
  end
  
end



