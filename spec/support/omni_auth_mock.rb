module OmniAuthMock
  def mock_omni_auth(token = "token", secret = "secret")
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: "twitter",
      uid: "123545",
      credentials: {
        token: token,
        secret: secret
      }
    })
  end
end
