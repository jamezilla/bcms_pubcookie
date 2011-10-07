module Pubcookie
  module ControllerHelper

    # This sets the OnDemandKey cookie, which Apache uses to redirect
    # to the login server. For the most part, you want "location" to
    # be the referer (e.g. login redirect), but for pages protected by
    # a :login_required filter, you want "location" to be
    # request.url, thus it's parameterized
    def handle_pubcookie_ondemand(location = request.env["HTTP_REFERER"])
      response.headers["Cache-control"] = "no-store, no-cache, must-revalidate"
      response.headers["Expires"] = "Sat, 1 Jan 2000 01:01:01 GMT"
      response.headers["Set-Cookie"] = "OnDemandKey=ondemand; path=/"

      # make sure we redirect back to something sensible
      back = location || my_root_url || request.host

      # logger.debug "--- Handling login with pubcookie"
      # logger.debug "--- OnDemand redirect: " + back
      # logger.debug "---          location: " + location
      # logger.debug "---           referer: " + request.env["HTTP_REFERER"].to_s
      # logger.debug "---       my_root_url: " + my_root_url.to_s
      # logger.debug "---              host: " + request.host.to_s

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
