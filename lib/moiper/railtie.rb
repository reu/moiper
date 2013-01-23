module Moiper
  class Railtie < Rails::Railtie
    # Expose Moiper's configuration to the Rails application configuration.
    #
    #   module MyApplication
    #     class Application < Rails::Application
    #       config.moiper.sandbox = true
    #       config.moiper.token = "teste"
    #       config.moiper.key = "secret"
    #     end
    #   end
    config.moiper = Moiper

    initializer "load notification controller helper" do
      require "moiper/notification_controller_helper"
    end

    initializer "load moiper.yml file" do
      config_file = Rails.root.join("config", "moiper.yml")

      if config_file.file?
        yaml = YAML.load(File.read(config_file))[Rails.env]

        if yaml
          Moiper.configure do |config|
            config.sandbox = yaml["sandbox"]
            config.token = yaml["token"]
            config.key = yaml["key"]
          end
        end
      end
    end
  end
end
