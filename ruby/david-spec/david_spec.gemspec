Gem::Specification.new do |gem|
  gem.name = "david_spec"
  gem.executables = ["david_spec"]
  gem.version = '1.0'
  gem.summary = 'Simple list test framework'
  gem.authors = ['dmragone@gmail.com']
  gem.files = `git ls-files lib/ bin/`.split("\n")
  gem.test_files = `git ls-files -- {test}/*`.split("\n")
  gem.require_paths = ['lib']
end
