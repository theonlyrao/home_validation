require 'rails_helper'

RSpec.feature "RootPathHasContents", type: :feature do
  it "has links for validate, complain, and search" do
    visit root_path
    expect(current_path).to eq("/")

    expect(page).to have_content("Validate A Home")

    click_on "Validate a home"
    expect(current_path).to eq("/validate")
  end
end
