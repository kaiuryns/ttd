Gem::Specification.new do |s|
  s.name        = 'ttd'
  s.version     = '0.0.0'
  s.summary     = 'Things To Do!'
  s.description = 'A simple todo list'
  s.authors     = ['kaiuryns']
  s.email       = 'kaiuryns@gmail.com'
  s.homepage    = 'https://github.com/kaiuryns/ttd'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 3.4'

  s.files       = `git ls-files -z`.split("\x0")
  s.bindir      = 'bin'
  s.executables = ['ttd']

  s.add_development_dependency 'minitest', '~> 5.0'
  s.add_development_dependency 'rake', '~> 13.0'
end
