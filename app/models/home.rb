class Home < ActiveRecord::Base
  has_and_belongs_to_many :pictures
  has_many :validations
  validates_presence_of :address_1, :city, :zip

  accepts_nested_attributes_for :validations
  accepts_nested_attributes_for :pictures
  
  def create_lat_and_long(mapping_service=GmapsService.new)
    address_args = self.parse_address
    lat_and_long = mapping_service.get_lat_and_long(address_args)
    self.lat = lat_and_long[:lat].to_s
    self.long = lat_and_long[:long].to_s
    self.save
  end

  def parse_address
    street = self.address_1.split.join("+")
    city = self.city.split.join("+")
    state = self.state
    zip = self.zip.split
    { street: street, city: city, state: state, zip: zip }
  end
  
end
