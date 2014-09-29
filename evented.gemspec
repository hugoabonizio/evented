Gem::Specification.new do |s|
  s.name        = 'evented'
  s.version     = '0.0.2'
  s.date        = '2014-09-28'
  s.summary     = "Gorki"
  s.description = "Event-driven and async IO Ruby gem"
  s.authors     = ["Hugo Abonizio"]
  s.email       = 'hugo_abonizio@hotmail.com'
  s.files       = %w{README.md evented.gemspec}
  s.files      += Dir.glob("lib/**/*.rb")
  s.homepage    = 'https://github.com/hugoabonizio/evented'
  s.license     = 'MIT'
end