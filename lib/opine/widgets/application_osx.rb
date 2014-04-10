  class MyApplication < Cocoa::NSObject
    attr_accessor :block, :application

    def applicationDidFinishLaunching notification
      menubar = NSMenu.new.autorelease
      app_menu_item = NSMenuItem.new.autorelease
      menubar.addItem app_menu_item
      application.setMainMenu menubar

      app_menu = NSMenu.new.autorelease
      quit_menu_item = NSMenuItem.alloc.initWithTitle("Quit",
        action: :terminate,
        keyEquivalent: 'q'
      ).autorelease
      app_menu.addItem quit_menu_item
      app_menu_item.setSubmenu app_menu

      application.activateIgnoringOtherApps true

      block.call if block
    end
  end

class Opine::Application
  attr_accessor :application
  def initialize(&block)
    Cocoa::NSAutoreleasePool.new
    @application = Cocoa::NSApplication.sharedApplication
    application.setActivationPolicy Cocoa::NSApplicationActivationPolicyRegular

    @appDelegate = MyApplication.alloc.init.autorelease
    @appDelegate.application = application
    @appDelegate.block = ->() do
      instance_eval(&block) if block
    end
    application.setDelegate @appDelegate
    application.run
  end

  def running?
    application.isRunning
  end

  def terminate
    @application.terminate @application
  end
  def stop
    @application.stop @application
  end
end

module Opine
  def self.app(&block)
    Application.new(&block)
  end
end
