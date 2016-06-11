class GmapsService

  def initialize
    @key = Pusher.gmaps_js_api
    @conn = Faraday.new("https://maps.googleapis.com/maps/api/geocode/")
  end

  def get_mapped_info(address)
    response = @conn.get("json?address=#{address[:street]},#{address[:city]},#{address[:state]},#{address[:zip]}&key=#{@key}")
    parsed = JSON.parse(response.body)
    if parsed["status"] == "ZERO_RESULTS"
      { lat: nil, long: nil }
    else
      lat = parsed["results"].first["geometry"]["location"]["lat"]
      long = parsed["results"].first["geometry"]["location"]["lng"]
      address = parsed["results"].first["formatted_address"]
      { lat: lat, long: long, address: address }
    end
  end

end
