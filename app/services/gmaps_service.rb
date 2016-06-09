class GmapsService

  def initialize
    @key = Pusher.gmaps_js_api
    @conn = Faraday.new("https://maps.googleapis.com/maps/api/geocode/")
  end

  def get_lat_and_long(address)
    response = @conn.get("json?address=#{address[:street]},#{address[:city]},#{address[:state]},#{address[:zip]}&key=#{@key}")
    parsed = JSON.parse(response.body)
    lat = parsed["results"].first["geometry"]["location"]["lat"]
    long = parsed["results"].first["geometry"]["location"]["lng"]
    { lat: lat, long: long }
  end

end
