require_relative '../spec_helper'

RSpec.describe Product do
  describe '#initialize' do
    before do
      @file_path = "#{File.dirname(__FILE__)}/../../inputs/input1.csv"
    end

    it 'should initialize the line items by the rows in given file' do
      receipt = Receipt.new(@file_path)
      expect(receipt.line_items.class).to be(Array)
      expect(receipt.line_items.size).to be(3)
      expect(receipt.line_items.first.class).to be(LineItem)
    end
  end

  describe '#print' do
    before do
      @file_path = "#{File.dirname(__FILE__)}/../../inputs/input1.csv"
    end

    it 'should initialize the line items by the rows in given file' do
      receipt = Receipt.new(@file_path)
      expect(STDOUT).to receive(:puts).with('1, book, 12.49')
      expect(STDOUT).to receive(:puts).with('1, music cd, 16.49')
      expect(STDOUT).to receive(:puts).with('1, chocolate bar, 0.85')
      expect(STDOUT).to receive(:puts).with('Sales Tax: 1.5')
      expect(STDOUT).to receive(:puts).with('Total: 29.83')
      receipt.print
    end
  end
end

