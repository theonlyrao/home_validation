require 'rails_helper'

RSpec.feature "LandlordCanSeeValidations", type: :feature do
  it "lets landlord see validations" do
    user = User.find_or_create_by(uid: "123545", name: "login_test", provider: "facebook", oauth_token: "oauth_facebook_test_token", oauth_expires_at: Time.at(99999999999))

    user_home_one = Home.create(lat: "100", long: "200", address: "user home one")
    user_home_two = Home.create(lat: "100", long: "200", address: "user home two")
    random_home = Home.create(lat: "100", long: "200", address: "random")

    home_one_picture = Picture.create()
    user_home_one.pictures << home_one_picture
    
    user_val_one = Validation.create(home_id: user_home_one.id, user_id: user.id, validated: true)
    user_val_two = Validation.create(home_id: user_home_two.id, user_id: user.id, validated: false)
    
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit user_path(user)
    
    within (".page-title") do
      expect(page).to have_content(user.name)
    end
    within ("ol") do
      expect(page).to have_link(user_home_one.address)
      expect(page).to have_link(user_home_two.address)
      expect(page).not_to have_link(random_home.address)
      click_on(user_home_one.address)
    end

    expect(current_path).to eq(validation_show_path(user_val_one.id))
  end
end
