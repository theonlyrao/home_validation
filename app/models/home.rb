class Home < ActiveRecord::Base
  has_and_belongs_to_many :pictures
  has_many :validations
  validates_presence_of :address

  accepts_nested_attributes_for :validations
  accepts_nested_attributes_for :pictures
  
  def self.bad_address?(raw_home, mapping_service=GmapsService.new)
    lat_and_long = mapping_service.get_mapped_info(raw_home)
    lat_and_long.values.include?(nil)
  end

  def self.build_home(raw_home, mapping_service=GmapsService.new)
    address_args = self.parse_address(raw_home)
    home_info = mapping_service.get_mapped_info(raw_home)
    self.create(home_info)
  end
  
  # def create_lat_and_long(mapping_service=GmapsService.new)
  #   address_args = self.parse_address
  #   lat_and_long = mapping_service.get_lat_and_long(address_args)
  #   self.lat = lat_and_long[:lat].to_s
  #   self.long = lat_and_long[:long].to_s
  #   self.save
  # end

  def self.parse_address(raw_home)
    street = raw_home[:address_1].split.join("+") || nil
    city = raw_home[:city].split.join("+") || nil
    state = raw_home[:state] || nil
    zip = raw_home[:zip].split || nil
    { street: street, city: city, state: state, zip: zip }
  end
  
end
