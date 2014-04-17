class Opine::Native::Table < Opine::Table
  def initialize parent,resources,options,&block
    @columns = options[:columns] || @resources.columns.map{ |col| col.name }

    treestore = Gtk::TreeStore.new(String)

    attribute_map = resources.columns.inject({}){ |map,item| map[item.name.to_sym] = item.type; map }
    types = @columns.map{ |name| attribute_map[name] || :string }
    treestore.set_column_types(*types.map{ |type| type.to_s.camelize.constantize })

    resources.to_a.each do |record|
      row = treestore.append(nil)
      @columns.each_with_index do |name,i|
        row[i] = record.send(name)
      end
    end

    @native = Gtk::TreeView.new(treestore)
    native.selection.mode = :single

    @columns.each_with_index do |name,i|
      renderer = Gtk::CellRendererText.new
      col = Gtk::TreeViewColumn.new(name.to_s.humanize, renderer, :text => i)
      native.append_column(col)
    end

    super(options)
    instance_eval(&block) if block

    native.signal_connect "cursor-changed" do
      path,column = native.cursor
      hooks[:on_select_row].call(path.indices.first) if hooks[:on_select_row]
    end

    parent.native.add(native)
  end
end
