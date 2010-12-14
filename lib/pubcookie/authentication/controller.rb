#
# Augments the core Cms::Controllers to add Pubcookie Authentication behavior.
#
module Pubcookie
  module Authentication
    module Controller
      # Called when this module is included on the given class.
      def self.included(controller_class)
        controller_class.send(:include, InstanceMethods)
        controller_class.alias_method_chain(:current_user, :pubcookie)
        controller_class.alias_method_chain(:access_denied, :pubcookie)
      end

      # Each instance of the controller will gain these methods.
      module InstanceMethods

        include Pubcookie::ControllerHelper

        protected

        # If the user is not logged in, this will be set to the guest
        # user, which represents a public user, who will likely have
        # more limited permissions
        def current_user_with_pubcookie
          @current_user ||= begin
            User.current = (login_from_pubcookie || User.guest)
          end
        end

        def access_denied_with_pubcookie
          respond_to do |format|
            format.html do
              # not sure this is the right thing to do...
              handle_pubcookie_ondemand
            end
          end
        end

        private
        
        # Attempts to set the current user based on the
        # HTTP_AUTHORIZATION variable set by pubcookie.
        def login_from_pubcookie
          logger.debug 'Attempting to login using pubcookie (2)'
          if login_id = parse_http_authorization
            begin
              return User.find_by_login(login_id)
            rescue RecordNotFound
              redirect_to '/system/access_denied'
            end
          else
            return nil
          end
        end

        # Extracts the username from pubcookie. The HTTP_AUTHORIZATION
        # string takes the form of "Basic" followed by the user's
        # login information encoded in Base64.
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
end

Cms::Authentication::Controller.send(:include, Pubcookie::Authentication::Controller)

