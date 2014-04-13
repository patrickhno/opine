class Opine::Native::Table < Opine::Table
  delegate :hooks, :reload, :to => :native

  class OSXTable < Cocoa::NSObject
    attr_accessor :table_view, :hooks
    def initialize parent,resources,options,&block
      super()

      @parent = parent
      @resources = resources
      @columns = options[:columns] || @resources.columns.map{ |col| col.name }
      @hooks = {}

      table_container = Cocoa::NSScrollView.alloc.initWithFrame parent.frame.native
      @table_view = Cocoa::NSTableView.alloc.initWithFrame parent.frame.native

      columns = @columns.map do |name|
        col = Cocoa::NSTableColumn.alloc.initWithIdentifier name.to_s
        col.headerCell.setTitle name.to_s.humanize
        col.setWidth parent.frame.width / @columns.size
        table_view.addTableColumn col
        col
      end

      table_view.setDelegate self
      table_view.setDataSource self
      table_view.reloadData

      table_container.setDocumentView table_view
      table_container.setHasVerticalScroller true

      if parent.is_a? Opine::Window
        parent.content_view << table_container
      end

      table_container.setAutoresizingMask NSViewWidthSizable | NSViewHeightSizable

      table_container.release
      table_view.release
      columns.each do |col|
        col.release
      end
    end

    def reload
      @cache = @resources.to_a
      table_view.reloadData
    end

  private
    def cache
      @cache ||= @resources.to_a
    end

    def numberOfRowsInTableView table_view
      cache.size
    end

    def tableView(table_view, objectValueForTableColumn: nil, row: nil)
      cache[row].send(objectValueForTableColumn.identifier.to_s.to_sym).to_s
    end

    def tableView(table_view, shouldSelectRow: nil)
      hooks[:on_select_row].call(shouldSelectRow) if hooks[:on_select_row]
      true
    end
  end

  def initialize window,resources,options,&block
    @parent = parent
    @resources = resources
    @resources = @resources.to_s.singularize.classify.constantize.all if @resources.is_a?(Symbol)
    @native = OSXTable.new(window,@resources,options,&block)
    instance_eval(&block) if block
  end
end
