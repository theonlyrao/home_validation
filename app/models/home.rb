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
    home_info = mapping_service.get_mapped_info(address_args)
    self.create(home_info)
  end

  def self.parse_address(raw_home)
    street = raw_home[:address].split.join("+") || nil
    city = raw_home[:city].split.join("+") || nil
    state = raw_home[:state] || nil
    zip = raw_home[:zip].split || nil
    { street: street, city: city, state: state, zip: zip }
  end
  
end
