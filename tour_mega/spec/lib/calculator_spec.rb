require_relative '../spec_helper'

RSpec.describe Calculator do
  describe '.calculate_service_tax' do
    it "Should return sales tax of given amount" do
      price = 100
      expect(Calculator.calculate_service_tax(100)).to be (10.00)
    end
  end

  describe '.calculate_import_duty' do
    it "Should return import duty of given amount" do
      price = 100
      expect(Calculator.calculate_import_duty(100)).to be (5.00)
    end
  end
end
