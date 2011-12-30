module Pubcookie

  # Extends the core UsersController to prepend view paths
  module UsersController

    def self.included(controller_class)
      controller_class.send(:include, InstanceMethods)
      controller_class.before_filter(:add_view_paths)
      controller_class.alias_method_chain(:create, :pubcookie)
      
    end

    module InstanceMethods

      def create_with_pubcookie
        @object = build_object(params[variable_name])
        @object.set_fake_password!

        if @object.save
          flash[:notice] = "User '#{ @object.first_name} #{ @object.last_name}' was created"
          redirect_to after_create_url
        else
          if (params[:on_fail_action])
            render :action => params[:on_fail_action]
          else
            render :action => 'new'
          end
        end
      end

      private

      def add_view_paths
        prepend_view_path(File.join(__FILE__, "..", "..", "..", "app", "views"))
        # logger.debug view_paths.inspect.to_s
      end

    end
  end

end
