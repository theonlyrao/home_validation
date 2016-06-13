require 'rails_helper'

RSpec.feature "UserCanLogins", type: :feature do
  it "lets the landlord login" do
    landlord = create(:user)
    visit root_path
    within (".navbar") do
      expect(page).to have_content("Login")
    end
  end
end
