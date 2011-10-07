# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "bcms_pubcookie"
  s.version     = "0.3.0"
  s.authors     = ["James Hughes"]
  s.email       = ["james@virtualjames.com"]
  s.homepage    = "http://github.com/jamezilla/bcms_pubcookie"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "bcms_pubcookie"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "rails", "~> 3.0"
  s.add_runtime_dependency "browsercms", "~> 3.3"
end
