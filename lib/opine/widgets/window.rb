class Opine::Window < Opine::Widget
  attr_accessor :window, :title, :content_view, :frame
  delegate :x, :y, :width, :height, :x=, :y=, :width=, :height=, :to => :frame

  DEFAULTS = {
    :title => 'ruby',
    :frame => Opine::Rect.new(x: 0, y: 0, width: 320, height: 240)
  }
end

class Opine::Application
  def window(options={},&block)
    "Opine::#{theme.to_s.camelize}::Window".constantize.new(Opine::Window::DEFAULTS.merge(options),&block)
  end
end
