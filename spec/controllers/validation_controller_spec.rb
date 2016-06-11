require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  it "can handle submission without address" do
    VCR.use_cassette "controller_with_no_addres" do
      #post :homes_path, homes: {:pictures_attributes => fixture_file_upload('turing3.jpg', 'image/jpeg')}
      post :create, home: {pictures_attributes: {"0" => {picture: Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'turing3.jpg'), 'image/jpeg')}}}
      expect(response).to render_template :new
      expect(flash[:error]).to be_present
    end
  end
end
