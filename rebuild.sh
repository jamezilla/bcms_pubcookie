#!/bin/bash
gem build bcms_pubcookie.gemspec --verbose
gem install bcms_pubcookie-0.1.0.gem 
sudo apachectl restart
#tail -f ~/src/dxarts/log/development.log 