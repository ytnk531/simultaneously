class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:twitter]

  def self.from_omniauth(auth_hash)
    credentials = auth_hash.credentials
    find_or_initialize_by(twitter_secret: credentials.secret, twitter_token: credentials.token)
  end
end
