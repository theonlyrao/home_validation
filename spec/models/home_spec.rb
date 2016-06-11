require 'rails_helper'

RSpec.describe Home, type: :model do
  it { should validate_presence_of(:address) }
  it { should have_and_belong_to_many(:pictures) }
  it { should have_many(:validations) }

  # it "creates lat and long before saving in database" do
  #   VCR.use_cassette("model_home_lat_long") do
  #     turing = Home.create(address_1: "1510 Blake Street", city: "Denver", zip: "80202")
  #     turing.create_lat_and_long
  #     expect(turing.lat).to eq("39.7496354")
  #     expect(turing.long).to eq("-105.0001058")
  #   end
  # end

  it "knows a bad address" do
    VCR.use_cassette("model_home_with_bad_address") do
      result = Home.bad_address?(address_1: "adsflksjdf", city: "Deafdsr", zip: "8032402")
      expect(result).to eq(true)
    end
  end
  
  it "creates new home with complete gmaps address results" do
    VCR.use_cassette("model_home_with_complete_gmaps_results") do
      turing = Home.build_home(address_1: "1510 Blake Street", city: "Denver", zip: "80202")
      expect(turing.lat).to eq("39.7541032")
      expect(turing.long).to eq("-105.0002242")
      expect(turing.address).to eq("1510 Blake Street, Denver, CO, 80202, USA")
    end
  end
end
