require 'rails_helper'

RSpec.feature "LandlordCanLogOuts", type: :feature do
  xit "lets the landlord logout" do
    landlord = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(landlord)
    visit user_path(landlord.id)
    within (".navbar") do
      expect(page).to have_content("Logout")
      click_on "Logout"
    end
    expect(current_path).to eq(root_path)
    within (".navbar") do
      expect(page).to have_content("Login")
    end
  end
end
