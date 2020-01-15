require_relative '../spec_helper'

RSpec.describe LineItem do
  before do
    @product = Product.new('music CD', '55.0')
    @line_item = LineItem.new(@product, '5')
  end

  describe '#initialize' do
    it 'should initialize product and quantity' do
      expect(@line_item.product).to be(@product)
      expect(@line_item.quantity).to be(5)
    end
  end

  describe '.build_from_file' do
    before do
      @file_path = "#{File.dirname(__FILE__)}/../../inputs/input1.csv"
    end

    it 'should build line item for each row in file' do
      line_items = LineItem.build_from_file(@file_path)
      expect(line_items.class).to be(Array)
      expect(line_items.size).to be(3)
      expect(line_items.first.class).to be(LineItem)
      expect(line_items.first.product.class).to be(Product)
    end
  end

  describe '#total_amount' do
    it 'should return total price of product with given quantity' do
      expect(@line_item.total_amount).to be((55.0 + 5.5) * 5)
    end
  end

  describe '#total_tax' do
    it 'should return total price of product with given quantity' do
      expect(@line_item.tax_amount).to be(5.5 * 5)
    end
  end
end

