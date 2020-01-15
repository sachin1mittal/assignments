require_relative 'lib/receipt'

purchase_list_1 = "#{File.dirname(__FILE__)}/inputs/input1.csv"
purchase_list_2 = "#{File.dirname(__FILE__)}/inputs/input2.csv"
purchase_list_3 = "#{File.dirname(__FILE__)}/inputs/input3.csv"

Receipt.new(purchase_list_1).print
Receipt.new(purchase_list_2).print
Receipt.new(purchase_list_3).print
