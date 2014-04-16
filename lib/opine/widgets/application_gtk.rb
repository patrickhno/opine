class Opine::Native::Application < Opine::Application
  def initialize(options,&block)
    super

    Gtk.init
    instance_eval(&block) if block
    Gtk.main
  end
end
