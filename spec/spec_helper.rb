$: << File.expand_path(File.join(File.dirname(__FILE__), '/../lib'))

require 'bacon'
require 'mocha-on-bacon'
require 'opine'

appf = Fiber.new do
  Opine.app do |app|
    Fiber.yield app
  end
end

$application = appf.resume

class Bacon::Context
  def method_missing method,*args,&block
    $application.send(method,*args,&block)
  end
end
