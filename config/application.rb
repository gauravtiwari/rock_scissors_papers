require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Rspgame
  class Application < Rails::Application

    #Autoload paths for services and policies
    config.autoload_paths += Dir["#{config.root}/app/services/*"]
    config.autoload_paths += Dir["#{config.root}/app/policies/*"]

    #Setup react for server rendering
    config.react.addons = true
    config.react.server_renderer_pool_size  ||= 5
    config.react.server_renderer_timeout    ||= 20
    config.react.server_renderer = React::ServerRendering::SprocketsRenderer
    config.react.server_renderer_options = {
        files: ["react.js", "components.js"],
        replay_console: true,
    }

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.active_record.schema_format = :sql

  end
end
