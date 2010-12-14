module Pubcookie
  module ControllerHelper

    def handle_pubcookie_ondemand
      logger.debug "Handling login with pubcookie."
      response.headers["Cache-control"] = "no-store, no-cache, must-revalidate"
      response.headers["Expires"] = "Sat, 1 Jan 2000 01:01:01 GMT"
      response.headers["Set-Cookie"] = "OnDemandKey=ondemand; path=/"
      back = request.env["HTTP_REFERER"] || my_root_url || request.host
      redirect_to ensure_ssl(back)
    end
    
    private

    def ensure_ssl(url_or_path)
      if url_or_path.include?('https://')
        return url_or_path
      elsif url_or_path.include?('http://')
        return url_or_path.sub('http://', 'https://')
      else
        return "http://" + url_or_path
      end
    end

    def my_root_url
      return defined?(root_url) ? root_url : nil
    end

  end  
end
