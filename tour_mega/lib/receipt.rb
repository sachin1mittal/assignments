require_relative 'line_item'

class Receipt
  attr_accessor :line_items

  def initialize(input_file_path)
    self.line_items = LineItem.build_from_file(input_file_path)
  end

  def print
    line_items.each do |line_item|
      puts "#{line_item.quantity}, #{line_item.product.name}, #{line_item.total_amount}"
    end

    puts "Sales Tax: #{total_tax}"
    puts "Total: #{total_amount}"
  end

  private

  def total_tax
    line_items.map(&:tax_amount).sum
  end

  def total_amount
    line_items.map(&:total_amount).sum
  end
end
