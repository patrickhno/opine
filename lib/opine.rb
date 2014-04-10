
module Opine
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
    :native
  end
end

case Opine.platform
when :osx
  require 'cocoa'
end
require 'cairo'

require 'opine/widget'
[:application, :alert, :window].each do |widget|
  [
    "#{widget}",
    "#{widget}_#{Opine.platform}",
    "#{widget}_#{Opine.theme}",
    "#{widget}_#{Opine.theme}_#{Opine.platform}"
  ].each do |name|
    require "opine/widgets/#{name}" if File.exists?(File.dirname(__FILE__) + "/opine/widgets/#{name}.rb")
  end
end
