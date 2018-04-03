Gem::Specification.new do |s|
  s.name        = 'concurrent_queue'
  s.version     = '0.0.0'
  s.date        = '2018-04-02'
  s.summary     = 'Listen to multiple queues concurrently.'
  s.description = 'Listen to multiple queues concurrently and return the value of the first queue to have an item pushed to it.'
  s.authors     = 'Rob Fors'
  s.email       = 'mail@robfors.com'
  s.files       = Dir.glob("{lib,test}/**/*") + %w(LICENSE README.md)
  s.homepage    = 'https://github.com/robfors/concurrent_queue'
  s.license     = 'MIT'
end
