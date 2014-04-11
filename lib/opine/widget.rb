class Opine::Widget
  include Cocoa if Opine.platform == :osx
  def initialize options
    options.each do |key,value|
      send("#{key}=".to_sym,value)
    end
  end
end
