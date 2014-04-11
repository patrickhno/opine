
class Opine::Application < Opine::Widget

  class OSXApplication < Cocoa::NSObject
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

  def initialize(options,&block)
    super

    Cocoa::NSAutoreleasePool.new
    @application = Cocoa::NSApplication.sharedApplication
    application.setActivationPolicy Cocoa::NSApplicationActivationPolicyRegular

    delegate = OSXApplication.alloc.init.autorelease
    delegate.application = application
    delegate.block = ->() do
      instance_eval(&block) if block
    end
    application.setDelegate delegate
    application.run
  end

  def running?
    application.isRunning
  end

  def terminate
    application.terminate application
  end

  def stop
    application.stop application
  end
end
