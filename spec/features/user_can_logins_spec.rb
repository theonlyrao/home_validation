require 'rails_helper'

RSpec.feature "UserCanLogins", type: :feature do
  it "lets the landlord login" do
    user = User.find_or_create_by(uid: "123545", name: "login_test", provider: "facebook", oauth_token: "oauth_facebook_test_token", oauth_expires_at: Time.at(99999999999))
    visit root_path
    within (".navbar") do
      expect(page).to have_content("Login")
      click_on("Login")
    end
    expect(current_path).to eq(user_path(user.id))
  end
end
