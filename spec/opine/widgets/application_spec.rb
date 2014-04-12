require_relative '../../spec_helper'
require 'opine'

describe 'Application' do |t|
  it 'should have default parameters' do
    Opine::Native::Application.expects(:new).with(:theme => :native)
    Opine.app
  end

  it 'should override default parameters' do
    Opine::Native::Application.expects(:new).with(:theme => :custom)
    Opine.app :theme => :custom
  end
end
