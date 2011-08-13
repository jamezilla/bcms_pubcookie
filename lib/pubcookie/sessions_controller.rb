require 'browsercms'

module Pubcookie

  # Extends the core SessionController to properly destroy the local
  # session on logout, and redirect to the Pubcookie server for
  # logout.
  module SessionsController
    def self.included(controller_class)
      controller_class.send(:include, InstanceMethods)
      controller_class.alias_method_chain :new, :pubcookie
      controller_class.alias_method_chain :destroy, :pubcookie
      controller_class.alias_method_chain :logout_user, :pubcookie
    end

    module InstanceMethods

      include Pubcookie::ControllerHelper

      def new_with_pubcookie
        handle_pubcookie_ondemand
      end

      # TODO: remove this dependency on apache for logout redirect?
      def destroy_with_pubcookie
        logger.debug "Handling logout with pubcookie."
        logout_user
        redirect_to '/logout-redirect'
      end

      def logout_user_with_pubcookie
        logger.debug "Deleting OnDemandKey cookie."
        cookies.delete :OnDemandKey
      end

    end
  end

end
  
Cms::SessionsController.send(:include, Pubcookie::SessionsController)
