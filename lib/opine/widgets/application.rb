class Opine::Application < Opine::Widget
  attr_accessor :title

  DEFAULTS = { :theme => :native, :title => 'Opine' }

  def theme
    @@theme
  end
  def theme= theme
    @@theme = theme
  end
  def self.theme
    @@theme
  end
end

module Opine
  def self.app(options={},&block)
    Opine::Native::Application.new(Opine::Application::DEFAULTS.merge(options),&block)
  end
end
