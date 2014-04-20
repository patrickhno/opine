require_relative '../spec_helper'
require 'opine'

describe 'Opine' do |t|
  t.it 'should run applications' do
    $application.running?.should == true
  end

  t.it 'should open windows' do
    window do
      visible?.should == false
    end.visible?.should == true
  end

  t.it 'should open windows twice' do
    window do
      visible?.should == false
    end.visible?.should == true
  end
end
