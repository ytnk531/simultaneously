require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "webmock/rspec"

Dir[Rails.root.join("spec", "support", "**", "*.rb")].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
ActiveJob::Base.queue_adapter = :test
OmniAuth.config.test_mode = true
WebMock.disable_net_connect!(allow_localhost: true)
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end
  config.include Devise::TestHelpers, type: :view
  config.include OmniAuthMock, type: :system
  config.before(:each, type: :system) do
    mock_omni_auth
  end
end
