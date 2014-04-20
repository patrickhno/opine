class Opine::Native::Application < Opine::Application
  def initialize(options,&block)
    super

    Gtk.init
    @running = true
    instance_eval(&block) if block
    Gtk.main
  end

  def running?
    @running ? true : false
  end

  def stop
  end
end
