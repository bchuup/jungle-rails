require 'rails_helper'

RSpec.describe Product do
 describe 'Validations' do
  it "has a valid product" do
    @category = Category.create(name: 'Furniture' )
    @product = Product.new(name: "new chair", price: 124124, quantity: 45, category: @category)
    expect(@product).to be_valid
  end

    it "should have one error when name is nil" do
      @category = Category.create(name: 'Furniture' )
      @product = Product.create(name: nil, price: 124124, quantity: 45, category: @category)
      puts @product.errors.size
      puts @product.errors.full_messages
      expect(@product.errors.size).to eq(1)
    end
    it "should have three errors when price is nil" do
      @category = Category.create(name: 'Furniture' )
      @product = Product.create(name: 'chair', price: nil, quantity: 45, category: @category)
      puts @product.errors.size
      puts @product.errors.full_messages
      expect(@product.errors.size).to eq(3)
    end

    it "should have one errors when quantity is nil" do
      @category = Category.create(name: 'Furniture' )
      @product = Product.create(name: 'chair', price: 123412 , quantity: nil, category: @category)
      puts @product.errors.size
      puts @product.errors.full_messages
      expect(@product.errors.size).to eq(1)
    end

    it "should have one errors when category is nil" do
      @category = Category.create(name: 'Furniture' )
      @product = Product.create(name: 'chair', price: 123412 , quantity: 45, category: nil)
      puts @product.errors.size
      puts @product.errors.full_messages
      expect(@product.errors.size).to eq(1)
    end
  end
end



