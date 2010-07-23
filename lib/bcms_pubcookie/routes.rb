module Cms::Routes
  def routes_for_bcms_pubcookie
    namespace(:cms) do |cms|
      #cms.content_blocks :pubcookies
    end  
  end
end
