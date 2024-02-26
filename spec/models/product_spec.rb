require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do
    @category = Category.new(name: "Herbs")
  end
  
  describe 'Validations' do
    it 'should save a product with all four fields set' do
      product = Product.new(name: "Basil", price: 5, quantity: 10, category: @category)
      expect(product).to be_valid
    end

    it 'should validate the presence of a name' do
      product = Product.new(name: nil, price: 5, quantity: 10, category: @category)
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should validate the presence of a price' do
      product = Product.new(name: "Basil", price: nil, quantity: 10, category: @category)
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should validate the presence of a quantity' do
      product = Product.new(name: "Basil", price: 5, quantity: nil, category: @category)
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should validate the presence of a category' do
      product = Product.new(name: "Basil", price: 5, quantity: 10, category: nil)
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end