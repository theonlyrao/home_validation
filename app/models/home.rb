class Home < ActiveRecord::Base
  validates_presence_of :address_1, :city, :zip
  after_save :create_lat_and_long

  def create_lat_and_long
    street = self.address_1.split.join("+")
    city = self.city.split.join("+")
    state = self.state
    zip = self.zip.split
    conn = Faraday.new("https://maps.googleapis.com/maps/api/geocode/")
    response = conn.get("json?address=#{street},#{city},#{state},#{zip}&key=#{Pusher.gmaps_js_api}")
    parsed = JSON.parse(response.body)
    self.lat = parsed["results"].first["geometry"]["location"]["lat"].to_s
    self.long = parsed["results"].first["geometry"]["location"]["lng"].to_s
  end
  
end
