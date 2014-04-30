require_relative '../../spec_helper'
require 'opine'

describe 'Application' do |t|
  it 'should have default parameters' do
    Opine::Native::Application.expects(:new).with(:theme => :native, :title => 'Opine')
    Opine.app
  end

  it 'should override default parameters' do
    Opine::Native::Application.expects(:new).with(:theme => :custom, :title => 'Opine')
    Opine.app :theme => :custom
  end

  it 'should set title' do
    title.should == 'Opine'
    send(:title=,'Test')
    title.should == 'Test'
  end
end
