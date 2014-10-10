Gem::Specification.new do |s|
  s.name        = 'evented'
  s.version     = '0.0.4'
  s.date        = '2014-09-28'
  s.summary     = "Event-driven IO for Ruby"
  s.description = "Event-driven and async IO Ruby gem"
  s.authors     = ["Hugo Abonizio"]
  s.email       = 'hugo_abonizio@hotmail.com'
  s.files       = %w{README.md evented.gemspec}
  s.files      += Dir.glob("lib/**/*.rb")
  s.homepage    = 'https://github.com/hugoabonizio/evented'
  s.license     = 'MIT'
  s.add_dependency 'threading', '>= 0.0.1'
end