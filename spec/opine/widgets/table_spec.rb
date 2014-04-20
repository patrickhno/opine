require_relative '../../spec_helper'
require 'opine'

describe 'Table' do |t|
  it 'should pass parameters' do
    window do |win|
      Opine::Native::Table.expects(:new).with(self,{:columns => [:a, :b]},{ :parent => win })
      table(:columns => [:a, :b])
    end
  end

  it 'should accept hooks' do
    records = mock('Records')
    records.expects(:to_a).returns([])
    records.expects(:columns).returns({}) if Opine.platform == :gtk

    window do |win|
      table(records, :columns => [:a, :b]) do
        on_select_row do |i|
        end
        hooks[:on_select_row].class.should == Proc
      end
    end
  end
end
