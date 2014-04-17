class Opine::Native::Window < Opine::Window
  def initialize(options,&block)
    @native = Gtk::Window.new

    super

    native.set_default_size frame.width, frame.height
    native.set_window_position :center

    native.signal_connect "destroy" do 
      Gtk.main_quit 
    end

    instance_eval(&block) if block

    native.show_all
  end

  def title= name
    native.set_title name
  end
end
