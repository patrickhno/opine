
module Canvas
  def self.platform
    @platform ||= case RUBY_PLATFORM
    when /darwin/
      :osx
    when /linux/
      :gtk
    when /win/
      :win
    end
  end
  def self.theme
    :dark
  end
end

case Canvas.platform
when :osx
  require 'cocoa'
end
require 'cairo'

require 'canvas/widget'
[:application, :alert, :window].each do |widget|
  [
    "#{widget}",
    "#{widget}_#{Canvas.platform}",
    "#{widget}_#{Canvas.theme}",
    "#{widget}_#{Canvas.theme}_#{Canvas.platform}"
  ].each do |name|
    require "canvas/widgets/#{name}" if File.exists?(File.dirname(__FILE__) + "/canvas/widgets/#{name}.rb")
  end
end
