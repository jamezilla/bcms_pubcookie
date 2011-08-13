require 'browsercms'

module BcmsPubcookie
  class Engine < Rails::Engine
    include Cms::Module
  end
end