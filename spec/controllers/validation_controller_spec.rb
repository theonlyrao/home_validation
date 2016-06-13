require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  it "can handle submission without address" do
    VCR.use_cassette "controller_with_no_address" do
      post :create, home: {pictures_attributes: {"0" => {picture: Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'turing3.jpg'), 'image/jpeg')}}}
      assert_redirected_to validation_path
      expect(flash[:error]).to be_present
    end
  end

  it "can handle submission with bad address" do
    VCR.use_cassette "controller_with_bad_address" do
      post :create, home: {home: {address: "aoi;dljf", city: "Deasdr", state: "CO", zip: "992313280"}, pictures_attributes: {"0" => {picture: Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'turing3.jpg'), 'image/jpeg')}}}
      assert_redirected_to validation_path
      expect(flash[:error]).to be_present
    end
  end

  it "can handle submission with incomplete but usable address" do
    VCR.use_cassette "controller_with_usable_address" do
      post :create, home: {home: {address: "", city: "Denver", state: "CO", zip: "80202"}, pictures_attributes: {"0" => {picture: Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'turing3.jpg'), 'image/jpeg')}}}
      assert_redirected_to validation_show_path(Validation.last.id)
      expect(Validation.last.validated?).to eq(false)
    end
  end

  it "can handle submission with no picture" do
    VCR.use_cassette "controller_with_no_picture" do
      post :create, home: {home: {address: "1501 Blake Street", city: "Denver", state: "CO", zip: "80202"}}
      assert_redirected_to validation_path
      expect(flash[:error]).to be_present
    end
  end

  it "can handle submission with no gps metadata" do
    VCR.use_cassette "controller_with_no_gps_metadata" do
      post :create, home: {home: {address: "3937 Tennyson St", city: "Denver", state: "CO", zip: "80212"}, pictures_attributes: {"0" => {picture: Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'no_gps.jpg'), 'image/jpeg')}}}
      assert_redirected_to validation_path
      expect(flash[:error]).to be_present
    end
  end

  it "can handle submission with good input" do
    VCR.use_cassette "controller_with_good_input" do
      post :create, home: {home: {address: "1510 Blake Street", city: "Denver", state: "CO", zip: "80202"}, pictures_attributes: {"0" => {picture: Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'turing3.jpg'), 'image/jpeg')}}}
      expect(flash[:error]).not_to be_present
      assert_redirected_to validation_show_path(Validation.last.id)
    end
  end

end
