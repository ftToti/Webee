require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Webee
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    unless Rails.env.production?
        config.web_console.whitelisted_ips = '10.0.2.2'
    end

    config.time_zone = 'Tokyo' # 表示を日本時間にするため

    config.i18n.default_locale = :ja # エラーメッセージを日本語化するため
  end
end
