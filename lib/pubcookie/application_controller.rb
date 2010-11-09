module Pubcookie
  module ApplicationController

    # Called when this module is included on the given class.
    def self.included(controller_class)
      controller_class.send(:include, InstanceMethods)
      controller_class.before_filter(:set_toolbar_visibility)
    end

    module InstanceMethods
      def set_toolbar_visibility
        if !!params[:toolbar_visibility]
          session[:toolbar_visibility] = ((params[:toolbar_visibility] == "true") ? true : false)
        else
          if session[:toolbar_visibility].nil?
            session[:toolbar_visibility] = false
          end
        end
        Rails.logger.debug "--- setting toolbar_visibility: #{session[:toolbar_visibility].to_s}"
      end
    end

  end
end
  
Cms::ApplicationController.send(:include, Pubcookie::ApplicationController)
