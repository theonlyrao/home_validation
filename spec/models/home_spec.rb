require 'rails_helper'

RSpec.describe Home, type: :model do
  it { should validate_presence_of(:address_1) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:zip) }
  it { should have_and_belong_to_many(:pictures) }
  it { should have_many(:validations) }

  it "creates lat and long before saving in database" do
    VCR.use_cassette("model_home_lat_long") do
      turing = Home.new(address_1: "1510 Blake Street", city: "Denver", zip: "80202")
      result = turing.save
      expect(result).to eq(true)
      expect(turing.lat).to eq("39.7496354")
      expect(turing.long).to eq("-105.0001058")
    end
  end
end
