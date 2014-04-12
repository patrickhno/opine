
  class TitleView < Cocoa::NSView
    def drawRect rect
      width = frame[:size][:width]
      height = frame[:size][:height]

      # rounded corners
      NSColor.clearColor.set
      NSRectFill(NSMakeRect(0, height-1, 4, 1))
      NSRectFill(NSMakeRect(0, height-2, 2, 1))
      NSRectFill(NSMakeRect(0, height-4, 1, 2))
      NSRectFill(NSMakeRect(width-4, height-1, 4, 1))
      NSRectFill(NSMakeRect(width-2, height-2, 2, 1))
      NSRectFill(NSMakeRect(width-1, height-4, 1, 2))

      # NSRectFill(NSMakeRect(fw - 2, 22, 2, 1))
      # NSRectFill(NSMakeRect(fw - 1, 21, 1, 1))

      context = NSGraphicsContext.currentContext.graphicsPort

      Cocoa::CGContextTranslateCTM(context, 0.0, rect[:size][:height])
      Cocoa::CGContextScaleCTM(context, 1.0, -1.0)

      Cairo::QuartzSurface.new(context, rect[:size][:width], rect[:size][:height]) do |surface|
        cr = Cairo::Context.new(surface)
        cr.push_group

        # clip path
        cr.move_to(0, height)
        cr.line_to(0, 5)
        cr.curve_to(0, 2, 2, 0, 5, 0)
        cr.line_to(width-5, 0)
        cr.curve_to(width-2, 0, width, 2, width, 5)
        cr.line_to(width, height)
        cr.clip
        cr.new_path

        # gradients in heading
        pat = Cairo::LinearPattern.new(0.0, 0.0, 0.0, height/2.0)
        pat.add_color_stop(0, 0.0, 0.0, 0.0)
        pat.add_color_stop(1, 0.2, 0.2, 0.2)
        cr.rectangle(0, 0, width, (height/2.0))
        cr.set_source(pat)
        cr.fill

        pat = Cairo::LinearPattern.new(0.0, 0.0, 0.0, height/2.0)
        pat.add_color_stop(0, :black)
        pat.add_color_stop(1, :black)
        cr.rectangle(0, height/2.0-1, width, height/2.0)
        cr.set_source(pat)
        cr.fill

        # specular rim
        cr.set_source_color([0.4,0.4,0.4])
        cr.set_line_width(3)

        cr.move_to(0, 5)
        cr.curve_to(0, 2, 2, 0, 5, 0)
        cr.line_to(width-5, 0)
        cr.curve_to(width-2, 0, width, 2, width, 5)
        cr.stroke

        # outer rim
        cr.set_source_color(:black)
        cr.set_line_width(2)

        cr.move_to(0, height-1)
        cr.line_to(0, 5)
        cr.curve_to(0, 2, 2, 0, 5, 0)
        cr.line_to(width-5, 0)
        cr.curve_to(width-2, 0, width, 2, width, 5)
        cr.line_to(width, height-1)
        cr.stroke

        cr.pop_group_to_source
        cr.paint
      end
    end

    def mouseDragged theEvent
      origin = window.frame[:origin]
      window.setFrameOrigin NSMakePoint(origin[:x] + theEvent.deltaX, origin[:y] - theEvent.deltaY)
    end

    def isOpaque
      true
    end
  end

class Opine::Dark::Window < Opine::Native::Window
  def initialize(options,&block)
    super do |win|
      win.window.setOpaque false
      win.window.setHasShadow true

      view = TitleView.alloc.initWithFrame NSRect.new(x: frame.x, y: frame.height-22, width: frame.width, height: 22)
      window.contentView.addSubview view
      view.setAutoresizingMask(NSViewWidthSizable | NSViewHeightSizable)

      instance_eval(&block) if block
    end
  end

  def native_style
    NSResizableWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask
  end
end
