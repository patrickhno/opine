class Opine::Window < Opine::Widget
  attr_accessor :window, :title
  def initialize(&block)
    @block = block

    @window = Cocoa::NSWindow.alloc.initWithContentRect(NSRect.new(x: 0, y: 0, width: 200, height: 200),
      styleMask: native_style,
      backing: NSBackingStoreBuffered,
      defer: false)
    window.setMinSize NSSize.new(width: 200, height: 200)

    point = CGPoint.new
    point[:x] = 120.0
    point[:y] = 220.0
    window.cascadeTopLeftFromPoint point
    self.title = 'Test app'

    instance_eval(&block) if block

    window.makeKeyAndOrderFront nil
  end

  def native_style
    NSTitledWindowMask | NSResizableWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask
  end

  def canBecomeKeyWindow
    true
  end

  def title= name
    window.setTitle name
  end

  def visible?
    window.isVisible
  end
end

class Opine::Application
  def window(&block)
    Opine::Window.new(&block)
  end
end
