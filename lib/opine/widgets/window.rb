class Opine::Window < Opine::Widget
  attr_accessor :window, :title
end

class Opine::Application
  def window(options={ :title => 'ruby' },&block)
    "Opine::#{theme.to_s.camelize}::Window".constantize.new(options,&block)
  end
end
