require 'rails_helper'

RSpec.feature "LandlordCanValidateHomes", type: :feature do
  scenario "landlord must submit photo" do
    VCR.use_cassette "feature_landlord_one_home" do
      landlord = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(landlord)
      visit validation_path
      within ".address-form" do
        fill_in "Address 1", with: "1510 Blake St"
        fill_in "State", with: "CO"
        fill_in "Zip", with: "80202"
      end
      click_on "Validate"
      expect(current_path).to eq(validation_path)
    end
  end
end
