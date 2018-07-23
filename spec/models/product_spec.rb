require 'rails_helper'

RSpec.describe Product, type: :model do
  context "Validations" do

    before :each do
      @category = Category.find_or_create_by! name: "Random"
    end

    it "should save when all fields filled out" do
      @category.products.create({
        name: "Random Item",
        price: 99.99,
        quantity: 10
        })
    end

    it "should fail when name missing" do
      @product = @category.products.create({
        name: nil,
        price: 99.99,
        quantity: 10
      })
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should fail when price missing" do
      @product = @category.products.create({
        name: "Random Item",
        price: nil,
        quantity: 10
      })
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should fail when quantity missing" do
      @product = @category.products.create({
        name: "Random Item",
        price: 99.99,
        quantity: nil
      })
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should fail when category missing" do
      @product = Product.create({
        name: "Random Item",
        price: 99.99,
        quantity: 10
      })
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end

# create_table "products", force: :cascade do |t|
#   t.string   "name"
#   t.text     "description"
#   t.string   "image"
#   t.integer  "price_cents"
#   t.integer  "quantity"
#   t.datetime "created_at",  null: false
#   t.datetime "updated_at",  null: false
#   t.integer  "category_id"
# end
