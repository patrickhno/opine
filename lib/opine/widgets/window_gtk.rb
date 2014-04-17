class Opine::Native::Window < Opine::Window
  def initialize(options,&block)
    @window = Gtk::Window.new

    super

    window.set_default_size frame.width, frame.height
    window.set_window_position :center

    window.signal_connect "destroy" do 
      Gtk.main_quit 
    end

    instance_eval(&block) if block

    window.show_all
  end

  def title= name
    window.set_title name
  end
end
