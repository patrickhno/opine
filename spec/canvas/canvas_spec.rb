require_relative '../spec_helper'
require 'canvas'

describe 'Canvas' do |t|
  Canvas.app do |app|
    t.it 'should run applications' do
      app.running?.should == true
    end

    t.it 'should open windows' do
      app.window do
        visible?.should == false
      end.visible?.should == true
    end

    t.it 'should open windows twice' do
      app.window do
        visible?.should == false
      end.visible?.should == true
    end

    terminate
  end
end
