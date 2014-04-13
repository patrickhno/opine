class Opine::Table < Opine::Widget
  attr_accessor :parent, :resources, :columns, :native

  def on_select_row(&block)
    hooks[:on_select_row] = block
  end
end

class Opine::Window
  def table(resources, options={}, &block)
    "Opine::#{Opine::Application.theme.to_s.camelize}::Table".constantize.new(self,resources, options, &block)
  end
end
