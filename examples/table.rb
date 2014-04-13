require 'opine'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDERR)

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => ":memory:"
)

ActiveRecord::Schema.define do
  create_table :records do |table|
    table.column :name, :string
  end
end

class Record < ActiveRecord::Base
end

(1..10).each do |i|
  Record.create! :name => "Record #{i}"
end

Opine.app do
  window :title => 'Table example' do
    table Record.all, :columns => [:id, :name] do
      on_select_row do |index|
        puts "SELECTED ROW #{index}"
      end
    end
  end
end
