class Canvas::Application
  def alert text
    application.activateIgnoringOtherApps true
    alert = Cocoa::NSAlert.alloc.init.autorelease
    alert.setMessageText text
    alert.runModal
  end
end
