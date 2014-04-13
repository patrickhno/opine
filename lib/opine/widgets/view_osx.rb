class Opine::View < Opine::Widget
  attr_accessor :view
  def initialize view
    @view = view
  end
  def << whatever
    view.addSubview whatever
  end
end
