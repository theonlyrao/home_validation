class User < ActiveRecord::Base
  has_many :validations

  def self.from_omniauth(auth)
    User.find_or_create_by(provider: auth.provider,
                           uid: auth.uid,
                           name: auth.info.name,
                           oauth_token: auth.credentials.token,
                           oauth_expires_at: Time.at(auth.credentials.expires_at))
    end
end

