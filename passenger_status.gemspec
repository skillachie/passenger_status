# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "passenger_status/version"

Gem::Specification.new do |s|
  s.name        = "passenger_status"
  s.version     = PassengerStatus::VERSION
  s.authors     = ["Dwayne Campbell"]
  s.email       = ["dwaynecampbell13@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Obtains Phusion Passenger Status}
  s.description = %q{Obtains the current status of Passenger by parsing results from passenger-status & passenger-memory-stats}

  s.rubyforge_project = "passenger_status"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
