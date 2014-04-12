class Opine::Rect
  attr_accessor :x,:y,:width,:height

  def initialize options
    options.each do |key,value|
      send("#{key}=".to_sym,value)
    end
  end

  def native
    Cocoa::NSRect.new(x: x, y: y, width: width, height: height)
  end

  def ==(other)
    x == other.x && y == other.y && width = other.width && height == other.height
  end
end
