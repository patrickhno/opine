class Opine::Alert < Opine::Widget
  attr_accessor :text
  def application
    parent
  end
end

class Opine::Application
  def alert(text, options={}, &block)
    "Opine::#{theme.to_s.camelize}::Alert".constantize.new(options.merge(:parent => self, :text => text),&block)
  end
end
