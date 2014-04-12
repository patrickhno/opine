
class Opine::Native::Window < Opine::Window
  def initialize(options,&block)
    @window = Cocoa::NSWindow.alloc.initWithContentRect(options[:frame].native,
      styleMask: native_style,
      backing: NSBackingStoreBuffered,
      defer: false)

    super

    window.setMinSize NSSize.new(width: 200, height: 200)

    point = CGPoint.new
    point[:x] = 120.0
    point[:y] = 220.0
    window.cascadeTopLeftFromPoint point

    instance_eval(&block) if block
    window.makeKeyAndOrderFront nil
  end

  def native_style
    NSTitledWindowMask | NSResizableWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask
  end

  def title= name
    window.setTitle name
  end

  def visible?
    window.isVisible
  end
end
