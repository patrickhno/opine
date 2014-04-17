
class Opine::Native::Window < Opine::Window
  def initialize(options,&block)
    @native = Cocoa::NSWindow.alloc.initWithContentRect(options[:frame].native,
      styleMask: native_style,
      backing: NSBackingStoreBuffered,
      defer: false)

    super

    native.setMinSize NSSize.new(width: 200, height: 200)

    point = CGPoint.new
    point[:x] = 120.0
    point[:y] = 220.0
    native.cascadeTopLeftFromPoint point

    @content_view = Opine::View.new(native.contentView)

    instance_eval(&block) if block

    native.makeKeyAndOrderFront nil
  end

  def native_style
    NSTitledWindowMask | NSResizableWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask
  end

  def title= name
    native.setTitle name
  end

  def visible?
    native.isVisible
  end
end
