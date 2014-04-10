class Canvas::Widget
  include Cocoa if Canvas.platform == :osx
end
