# bcms_pubcookie

This is a [BrowserCMS 3.3.x](https://github.com/browsermedia/browsercms) module for using
[Pubcookie](http://www.pubcookie.org/) authentication. It replaces the
standard BrowserCMS authentication and login.

Prerequisites:
* Apache
* [Passenger](http://www.modrails.com/)
* [Pubcookie Apache Module](http://www.pubcookie.org/docs/install-mod_pubcookie.html)
* [Rails 3.x](http://rubyonrails.org/)
* [BrowserCMS 3.3.x](https://github.com/browsermedia/browsercms)

## Installation

Add bmcs_pubcookie to your Gemfile

    gem 'bcms_pubcookie', :git => 'git://github.com/jamezilla/bcms_pubcookie.git'

Run 'bundle install'

Your apache config should look something like this:

    # pubcookie apache module
    LoadModule pubcookie_module  libexec/apache2/mod_pubcookie.so

    # fake basic auth apache module
    LoadModule fba_module        libexec/apache2/mod_fba.so

    <IfModule mod_pubcookie.c>
        PubcookieGrantingCertFile /path/to/pubcookie_granting.cert
        PubcookieSessionKeyFile /path/to/ssl.key.pem
        PubcookieSessionCertFile /path/to/ssl.crt.pem
        PubcookieLogin https://weblogin.washington.edu/
        PubcookieLoginMethod POST
        PubcookieKeyDir /usr/local/pubcookie/keys/
        PubcookieDomain .washington.edu
        PubcookieAuthTypeNames UWNetID null SecurID

        FakeBasicAuthEnable on
        FakeBasicAuthType UWNetID

        # force relogin to admin section
        <LocationMatch .*/cms/administration.*>
            authtype uwnetid
            require valid-user
            PubcookieSessionCauseReAuth 900
        </LocationMatch>

        # generic pubcookie logout
        # visiting www.dxarts.washington.edu/logout-redirect, will have
        # the following result:
        # - logged out of the application
        # - still logged into the weblogin service
        # - still identified by your uw netid
        # - redirected to the UW logout page
        <LocationMatch .*/logout-redirect.*>
            authtype uwnetid
            require valid-user
            PubcookieEndSession redirect
        </LocationMatch>

        # generic pubcookie logout
        # visiting www.dxarts.washington.edu/logout-clearlogin, will have
        # the following result:
        # - logged out of the application
        # - logged out of the weblogin service
        # - still identified by your uw netid
        # - redirected to the UW logout page
        <LocationMatch .*/logout-clearlogin.*>
            authtype uwnetid
            require valid-user
            PubcookieEndSession clearLogin
        </LocationMatch>
    </IfModule>

The logout-redirect LocationMatch directive above is critical if you
want the 'logout' link to work properly.
