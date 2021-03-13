module OmniAuthMock
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                                 :provider => 'twitter',
                                                                 :uid => '123545',
                                                                 credentials: {
                                                                   token: "token",
                                                                   secret: "secret"
                                                                 }
                                                               })
end