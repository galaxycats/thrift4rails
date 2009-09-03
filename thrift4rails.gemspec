# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{thrift4rails}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["pkw.de Development Team"]
  s.date = %q{2009-09-03}
  s.description = %q{module Thrift4Rails::ReleaseActiveRecordConnection ist in der Version 0.3.0 dazugekommen
Wenn das Modul inkludiert wird, wird nach jedem Methodenaufruf zusaetzlich ActiveRecord::Base.clear_active_connections! aufgerufen.}
  s.email = ["dev@pkw.de"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/thrift4rails.rb", "lib/thrift4rails/client_stub_for_testing.rb", "lib/thrift4rails/release_active_record_connection.rb", "lib/thrift4rails/tasks.rb", "lib/thrift4rails/tasks/generate.rake", "lib/thrift4rails/tasks/service.rake", "lib/thrift4rails/tasks/tunnel.rake", "lib/thrift4rails/thrift_client.rb", "script/console", "script/destroy", "script/generate", "tasks/Rakefile", "tasks/thrift.rb", "test/release_active_record_connection_test.rb", "test/test_helper.rb", "test/test_thrift4rails.rb", "thrift4rails.gemspec"]
  s.homepage = %q{http://github.com/#{github_username}/#{project_name}}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{thrift4rails}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{module Thrift4Rails::ReleaseActiveRecordConnection ist in der Version 0.3.0 dazugekommen Wenn das Modul inkludiert wird, wird nach jedem Methodenaufruf zusaetzlich ActiveRecord::Base.clear_active_connections! aufgerufen.}
  s.test_files = ["test/test_helper.rb", "test/test_thrift4rails.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_runtime_dependency(%q<activerecord>, [">= 2.3.2"])
      s.add_development_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_dependency(%q<activerecord>, [">= 2.3.2"])
      s.add_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.2"])
    s.add_dependency(%q<activerecord>, [">= 2.3.2"])
    s.add_dependency(%q<newgem>, [">= 1.4.1"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
