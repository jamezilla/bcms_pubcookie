# module Pubcookie
#   module PageHelper

#     def self.included(base)
#       base.send(:include, InstanceMethods)
#       base.alias_method_chain(:cms_toolbar, :pubcookie)
#     end

#     module InstanceMethods
#       def cms_toolbar_with_pubcookie
#         logger.debug "--- running pubcookie version of cms_toolbar"
#         return "<!-- no toolbar -->" unless session[:toolbar_visibility] == true
#         cms_toolbar_without_pubcookie
#       end
#     end

#     # def contributor_login
#     #   #render :partial => 'partials/contributor_login'
#     #   "<p>contributor login</p>"
#     # end

#   end
# end
# Cms::PageHelper.send(:include, Pubcookie::PageHelper)
# Rails.logger.info "~~ Loading Pubcookie::PageHelper"
