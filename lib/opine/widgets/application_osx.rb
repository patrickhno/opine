
class Opine::Native::Application < Opine::Application
  attr_accessor :application_menu

  class OSXApplication < Cocoa::NSObject
    attr_accessor :block, :application

    def applicationDidFinishLaunching notification
      menubar = NSMenu.new.autorelease
      app_menu_item = NSMenuItem.new.autorelease
      menubar.addItem app_menu_item
      application.native.setMainMenu menubar

      app_menu = application.application_menu = NSMenu.new.autorelease
      quit_menu_item = NSMenuItem.alloc.initWithTitle("Quit",
        action: :terminate,
        keyEquivalent: 'q'
      ).autorelease
      app_menu.addItem quit_menu_item
      app_menu_item.setSubmenu app_menu
      application.title = application.title

      application.native.activateIgnoringOtherApps true

      block.call if block
    end
  end

  def initialize(options,&block)
    super(options)

    Cocoa::NSAutoreleasePool.new
    @native = Cocoa::NSApplication.sharedApplication
    native.setActivationPolicy Cocoa::NSApplicationActivationPolicyRegular

    delegate = OSXApplication.alloc.init.autorelease
    delegate.application = self
    delegate.block = ->() do
      instance_eval(&block) if block
    end
    native.setDelegate delegate
    native.run
  end

  def running?
    native.isRunning
  end

  def terminate
    native.terminate native
  end

  def stop
    native.stop native
  end

  def title= title
    application_menu.setTitle(title) if application_menu
    @title = title
  end
end
