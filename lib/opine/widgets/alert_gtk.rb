class Opine::Native::Alert < Opine::Alert
  def initialize(options,&block)
    super

    md = Gtk::MessageDialog.new(
      :parent => nil, :flags => :destroy_with_parent,
      :type => :info, :buttons_type => :close, 
      :message => text
    )
    md.run
    md.destroy
  end
end

