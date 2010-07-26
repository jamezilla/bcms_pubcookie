require 'browsercms'

#
# Augments the core Cms::Controllers to add Pubcookie Authentication behavior.
#
module Pubcookie
  module Authentication
    module Controller
      # Called when this module is included on the given class.
      def self.included(controller_class)
        controller_class.send(:include, InstanceMethods)
      end

      # Each instance of the controller will gain these methods.
      module InstanceMethods

        protected

        # If the user is not logged in, this will be set to the guest user, which represents a public
        # user, who will likely have more limited permissions
        def current_user
          @current_user ||= begin
            User.current = (login_from_pubcookie || User.guest)
          end
        end

        private
        
        # Attempts to set the current user based on the HTTP_AUTHORIZATION variable set by pubcookie.
        def login_from_pubcookie
          logger.debug "Attempting to login using pubcookie."
          if login_id = parse_http_authorization
            return User.find_or_create_by_login(login_id)
          else
            return nil
          end
        end

        # Extracts the username from pubcookie. The HTTP_AUTHORIZATION
        # string takes the form of "Basic" followed by the user's login
        # information encoded in Base64.
        def parse_http_authorization
          if !request.env['HTTP_AUTHORIZATION'].nil?
            return request.env['HTTP_AUTHORIZATION'].split(' ')[1].unpack("m").to_s.split(':')[0]
          else
            return nil
          end
        end
      end
    end
  end
  Cms::Authentication::Controller.send(:include, Pubcookie::Authentication::Controller)


  # Extends the core SessionController to properly destroy the local
  # session on logout, and redirect to the Pubcookie server for
  # logout.
  module LogOut
    def self.included(controller_class)
      controller_class.send(:include, InstanceMethods)
      controller_class.alias_method_chain :destroy, :pubcookie
      controller_class.alias_method_chain :logout_user, :pubcookie
    end

    module InstanceMethods

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
  Cms::SessionsController.send(:include, Pubcookie::LogOut)
end
