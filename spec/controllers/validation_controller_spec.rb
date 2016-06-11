require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  it "can handle submission without address" do
    VCR.use_cassette "controller_with_no_address" do
      #post :homes_path, homes: {:pictures_attributes => fixture_file_upload('turing3.jpg', 'image/jpeg')}
      post :create, home: {pictures_attributes: {"0" => {picture: Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'turing3.jpg'), 'image/jpeg')}}}
      expect(response).to render_template :new
      expect(flash[:error]).to be_present
    end
  end

  it "can handle submission with bad address" do
    VCR.use_cassette "controller_with_bad_address" do
      post :create, home: {home: {address_1: "aoi;dljf", city: "Deasdr", state: "CO", zip: "992313280"}, pictures_attributes: {"0" => {picture: Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'turing3.jpg'), 'image/jpeg')}}}
      expect(response).to render_template :new
      expect(flash[:error]).to be_present
    end
  end

  it "can handle submission with no picture" do
    VCR.use_cassette "controller_with_no_picture" do
      post :create, home: {home: {address_1: "1501 Blake Street", city: "Denver", state: "CO", zip: "80202"}}
      expect(response).to render_template :new
      expect(flash[:error]).to be_present
    end
  end

  it "can handle submission with no gps metadata" do
    VCR.use_cassette "controller_with_no_gps_metadata" do
      post :create, home: {home: {address_1: "3937 Tennyson St", city: "Denver", state: "CO", zip: "80212"}, pictures_attributes: {"0" => {picture: Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'no_gps.jpg'), 'image/jpeg')}}}
      expect(response).to render_template :new
      expect(flash[:error]).to be_present
    end
  end
end
