# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController

  # TODO: DRY this up with bcms_pubcookie/lib/pubcookie/authentication/controller.rb
  def new
    response.headers["Cache-control"] = "no-store, no-cache, must-revalidate"
    response.headers["Expires"] = "Sat, 1 Jan 2000 01:01:01 GMT"
    response.headers["Set-Cookie"] = "OnDemandKey=ondemand; path=/"
    redirect_to request.request_uri
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_to '/logout-redirect'
    # redirect_back_or_default('/')
  end

end
