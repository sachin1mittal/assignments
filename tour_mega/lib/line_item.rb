require 'csv'
require_relative 'product'

class LineItem
  attr_accessor :product, :quantity

  def initialize(product, quantity)
    self.quantity = quantity.to_i
    self.product = product
  end

  def self.build_from_file(file_path)
    line_items = []

    CSV.foreach(file_path, headers: true) do |row|
      product = Product.new(row[1], row[2])
      line_items << LineItem.new(product, row[0])
    end

    line_items
  end

  def total_amount
    ((product.price + product.tax) * quantity).round(2)
  end

  def tax_amount
    (product.tax * quantity).round(2)
  end
end
