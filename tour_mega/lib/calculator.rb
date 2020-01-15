class Calculator
  def self.calculate_service_tax(price)
    ((price * 1.10) - price).round(2)
  end

  def self.calculate_import_duty(price)
    ((price * 1.05) - price).round(2)
  end
end
