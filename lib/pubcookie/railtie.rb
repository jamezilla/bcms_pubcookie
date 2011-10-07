require 'rails'
require 'browsercms'
require 'bcms_pubcookie'
require 'pubcookie/user_extensions'
require 'pubcookie/authentication/controller'
require 'pubcookie/sessions_controller'

module Pubcookie
  class Railtie < ::Rails::Railtie

    config.to_prepare do
      User.send(:include, Pubcookie::UserExtensions)
      Cms::Authentication::Controller.send(:include, Pubcookie::Authentication::Controller)
      Cms::SessionsController.send(:include, Pubcookie::SessionsController)
    end

  end
end
