class Opine::Application < Opine::Widget
  attr_accessor :application, :theme
end

module Opine
  def self.app(options={ :theme => :native },&block)
    Application.new(options,&block)
  end
end
