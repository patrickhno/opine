class Opine::Native::Alert < Opine::Alert
  def initialize(options,&block)
  	super

    application.activateIgnoringOtherApps true
    alert = Cocoa::NSAlert.alloc.init.autorelease
    alert.setMessageText text
    alert.runModal
  end
end

