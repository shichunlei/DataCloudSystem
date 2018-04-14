require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AuthDemo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :'zh-CN'
    config.middleware.use Rack::Pjax

    config.active_record.default_timezone = :local  # 注释1
    config.time_zone = 'Beijing'                    # 注释2
  end
end
