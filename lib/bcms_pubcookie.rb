require 'browsercms'

require 'pubcookie/controller_helper.rb'
require 'pubcookie/authentication/controller.rb'
require 'pubcookie/sessions_controller.rb'
require 'pubcookie/user.rb'

path = File.expand_path(File.dirname(__FILE__))
Rails.logger.info "~~ Loading bcms_pubcookie components from #{ path }"
