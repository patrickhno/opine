require_relative '../../spec_helper'
require 'opine'

describe 'Window' do |t|
  window = Opine::Window.new(:frame => Opine::Rect.new(x: 0, y: 0, width: 0, height: 0))

  it 'should delegate to frame' do
    window.x = 1
    window.y = 2
    window.width = 3
    window.height = 4
    window.frame.should == Opine::Rect.new(x: 1, y: 2, width: 3, height: 4)
    window.frame = Opine::Rect.new(x: 5, y: 6, width: 7, height: 8)
    window.x.should == 5
    window.y.should == 6
    window.width.should == 7
    window.height.should == 8
  end

  it 'should have default parameters' do
    app = Opine::Application.new(:theme => :native)
    Opine::Native::Window.expects(:new).with(:title => 'ruby', :frame => Opine::Rect.new(x: 0, y: 0, width: 320, height: 240), :parent => app)
    app.window
  end

  it 'should override default parameters' do
    app = Opine::Application.new(:theme => :native)
    Opine::Native::Window.expects(:new).with(:title => 'Yes it does', :frame => Opine::Rect.new(x: 0, y: 0, width: 320, height: 240), :parent => app)
    app.window(:title => 'Yes it does')
  end
end
