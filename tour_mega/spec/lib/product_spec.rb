require_relative '../spec_helper'

RSpec.describe Product do
  describe '#initialize' do
    context 'When product is sales tax exempted and not imported' do
      it "Should initialize tax amount to be zero" do
        product = Product.new('book', '100')
        expect(product.price).to be (100.0)
        expect(product.tax).to be (0.0)
      end

      it "Should initialize tax amount to be zero" do
        product = Product.new('chocolate bar', '200')
        expect(product.price).to be (200.0)
        expect(product.tax).to be (0.0)
      end

      it "Should initialize tax amount to be zero" do
        product = Product.new('packet of headache pills', '50')
        expect(product.price).to be (50.0)
        expect(product.tax).to be (0.0)
      end
    end

    context 'When product is sales tax exempted and imported' do
      it "Should initialize tax amount to be 5 percent of amount" do
        product = Product.new('imported box of chocolates', '100')
        expect(product.price).to be (100.00)
        expect(product.tax).to be (5.00)
      end
    end

    context 'When product is not sales tax exempted and not imported' do
      it "Should initialize tax amount to be 10 percent of amount" do
        product = Product.new('music CD', '25')
        expect(product.price).to be (25.0)
        expect(product.tax).to be (2.50)
      end
    end

    context 'When product is not sales tax exempted and imported' do
      it "Should initialize tax amount by adding both sales tax and import duty" do
        product = Product.new('imported bottle of perfume', '2500')
        expect(product.price).to be (2500.0)
        expect(product.tax).to be (375.0)
      end
    end
  end
end

