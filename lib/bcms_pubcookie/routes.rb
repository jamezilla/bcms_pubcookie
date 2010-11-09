module Cms::Routes
  def routes_for_bcms_pubcookie

    # map.login 'login', :controller => 'session', :action => 'new'
    # map.logout 'logout', :controller => 'session', :action => 'destroy'

    # Rails 3 equivalents
    # match '/login' => 'sessions#new', :as => 'login'
    # match '/logout' => 'sessions#destroy', :as => 'logout'

    namespace(:cms) do |cms|
      #cms.content_blocks :pubcookies
    end  
  end
end
