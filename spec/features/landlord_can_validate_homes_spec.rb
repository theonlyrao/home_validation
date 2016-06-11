# coding: utf-8
require 'rails_helper'

RSpec.feature "LandlordCanValidateHomes", type: :feature do
  xscenario "first iteration - just enter the lat and long" do
    VCR.use_cassette "feature_validation_iteration_1" do
      landlord = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(landlord)
      visit validation_path
      within ".address-submission" do
        fill_in "Address 1", with: "1510 Blake St"
        fill_in "City", with: "Denver"
        fill_in "State", with: "CO"
        fill_in "Zip", with: "80202"
        fill_in "Lat", with: "39.74963758333333"
        fill_in "Long", with: "-104.99990080555555"
      end
      click_on "Validate"
      expect(current_path).to eq("/validations/#{Validation.last.id}")
      within "h1" do
        expect(page).to have_content("Home Validated")
      end
      within ".address-report" do
        expect(page).to have_content("1510 Blake St")
        expect(page).to have_content("CO")
        expect(page).to have_content("80202")
        expect(page).to have_content("39.7496354")
        expect(page).to have_content("-105.0001058")        
      end
      within ".metadata" do
        expect(page).to have_content("39.74963758333333")
        expect(page).to have_content("-104.99990080555555")
      end
    end
  end

  xscenario "first iteration - bad photo info" do
    VCR.use_cassette "feature_validation_iteration_1_sad_path" do
      landlord = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(landlord)
      visit validation_path
      within ".address-submission" do
        fill_in "Address 1", with: "1510 Blake St"
        fill_in "City", with: "Denver"
        fill_in "State", with: "CO"
        fill_in "Zip", with: "80202"
        fill_in "Lat", with: "40.74963758333333"
        fill_in "Long", with: "-104.99990080555555"
      end
      click_on "Validate"
      expect(current_path).to eq("/validations/#{Validation.last.id}")
      within "h1" do
        expect(page).to have_content("Home Not Valid")
      end
      within ".address-report" do
        expect(page).to have_content("1510 Blake St")
        expect(page).to have_content("CO")
        expect(page).to have_content("80202")
        expect(page).to have_content("39.7496354")
        expect(page).to have_content("-105.0001058")        
      end
      within ".metadata" do
        expect(page).to have_content("40.74963758333333")
        expect(page).to have_content("-104.99990080555555")
      end
    end
  end

  xscenario "landlord is logged in do" do
    VCR.use_cassette "feature_landlord_one_home" do
# As a logged in landlord,
# when I go to /validate,
# and enter a valid address,
# and upload a picture with gps metadata,
# and click on "Validate,"
# I should see a page entitled "Home Validated,"
# that has the address I entered,
# a google map centered on my home,
# the picture I uploaded,
      # and the metadata associated with that photo.
      landlord = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(landlord)
      visit validation_path
      within ".address_submission" do
        fill_in "Address 1", with: "1510 Blake St"
        fill_in "State", with: "CO"
        fill_in "Zip", with: "80202"
      end
      #page.attach_file("Upload Picture", "make up file path")
      #image = fixture_file_upload "android2.jpg"
      click_on "Validate"
      expect(current_path).to eq("/homes/#{Home.last.id}")
      within "h1" do
        expect(page).to have_content("Home Validated")
      end
      within ".address_report" do
        expect(page).to have_content("1510 Blake St")
        expect(page).to have_content("CO")
        expect(page).to have_content("80202")
      end
      within ".metadata" do
        expect(page).to have_content("39°44'59.5\"N")
        expect(page).to have_content("105°00'00.4\"W")
      end
    end
  end
end
