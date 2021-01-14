require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module OE28Instagram
  class Application < Rails::Application
    config.load_defaults 6.0
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  end
end
