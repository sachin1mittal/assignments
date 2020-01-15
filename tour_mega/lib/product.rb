require_relative 'calculator'

class Product
  FOODS = ['chocolate bar', 'imported box of chocolates', 'box of imported chocolates']
  BOOKS = ['book']
  MEDICINES = ['packet of headache pills']
  IMPORTED = ['imported bottle of perfume', 'imported box of chocolates', 'box of imported chocolates']

  attr_accessor :name, :price, :tax

  def initialize(name, price)
    self.name = name
    self.price = price.to_f
    self.tax = calculate_tax
  end

  private

  def calculate_tax
    tax = 0.0
    tax += Calculator.calculate_service_tax(self.price) if !sales_tax_exempted?
    tax += Calculator.calculate_import_duty(self.price) if !import_duty_exempted?
    tax
  end

  def sales_tax_exempted?
    FOODS.include?(self.name) || BOOKS.include?(self.name) ||
      MEDICINES.include?(self.name)
  end

  def import_duty_exempted?
    !IMPORTED.include?(self.name)
  end
end
