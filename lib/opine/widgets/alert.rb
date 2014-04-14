class Opine::Alert < Opine::Widget
  attr_accessor :application, :text
end

class Opine::Application
  def alert(text, options={}, &block)
    "Opine::#{theme.to_s.camelize}::Alert".constantize.new(options.merge(:application => application, :text => text),&block)
  end
end
