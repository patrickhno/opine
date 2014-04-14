class Opine::Alert < Opine::Widget
  attr_accessor :text
end

class Opine::Application
  def alert(text, options={}, &block)
    "Opine::#{theme.to_s.camelize}::Alert".constantize.new(options.merge(:text => text),&block)
  end
end
