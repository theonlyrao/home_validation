require 'rails_helper'

RSpec.feature "RootPathHasContents", type: :feature do
  it "has links for validate, complain, and search" do
    visit root_path
    expect(current_path).to eq("/")

    expect(page).to have_content("Validate my listing")
    expect(page).to have_content("Search listings")
    expect(page).to have_content("Report scam")

    click_on "Validate my listing"
    expect(current_path).to eq("/validate")
  end
end
