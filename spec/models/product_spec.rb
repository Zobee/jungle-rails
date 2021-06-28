require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is valid if all attributes are valid' do
      category = Category.new(name: 'newCat')
      product = Product.new(      
        name: "newProd",
        category: category,
        quantity: 100,
        price: 100
      )
      expect(product).to be_valid
    end
    it 'is invalid if the name attribute is omitted' do
      category = Category.new(name: 'newCat')
      product = Product.new(  
        name: nil,    
        category: category,
        quantity: 100,
        price: 100
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Name can't be blank"
    end
    it 'is invalid if category attribute is omitted' do
      product = Product.new(      
        name: "newProd",
        category: nil,
        quantity: 100,
        price: 100
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Category can't be blank"
    end
    it 'is invalid if quantity attribute is omitted' do
      category = Category.new(name: 'newCat')
      product = Product.new(      
        name: "newProd",
        category: category,
        quantity: nil,
        price: 100
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Quantity can't be blank"
    end
    it 'is invalid if price attribute is omitted' do
      category = Category.new(name: 'newCat')
      product = Product.new(      
        name: "newProd",
        category: category,
        quantity: 100,
        price: nil
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Price can't be blank"
    end
  end
end
