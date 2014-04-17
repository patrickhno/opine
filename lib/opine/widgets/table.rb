class Opine::Table < Opine::Widget
  attr_accessor :resources, :columns

  def on_select_row(&block)
    hooks[:on_select_row] = block
  end
end

class Opine::Window
  def table(resources, options={}, &block)
    "Opine::#{Opine::Application.theme.to_s.camelize}::Table".constantize.new(self, resources, options.merge(:parent => self), &block)
  end
end
