require 'rails_helper'

RSpec.describe 'User' do
    context 'validation' do
        context 'name' do
            it 'presence' do
                user = User.new(name: nil)
                expect(user).to be_invalid
                expect(user.errors[:name]).to eq(["can't be blank"])
            end

            it 'lenght' do
                user = User.new(name: Array.new(300).join('a'))
                expect(user).to be_invalid
                expect(user.errors[:name]).to eq(["is too long (maximum is 255 characters)"])
            end
        end
    end

    context 'adding item' do 
        let(:user) { create_fake_user! }
        let(:product) { Product.create!(name: "Any", price: 2000) }
        let(:other_product) { Product.create!(name: "Any 2", price: 1000) }

        it 'add first product' do
            cart_item = user.add_cart_item(product: product, quantity: 2)
            expect(user.cart_items.length).to eq(1)
            expect(cart_item.total).to eq(4000)
        end

        it 'add same product' do
            user.add_cart_item(product: product, quantity: 2)
            cart_item = user.add_cart_item(product: product, quantity: 3)
            expect(user.cart_items.length).to eq(1)
            expect(cart_item.quantity).to eq(5)
            expect(cart_item.total).to eq(10000)
        end

        it 'add different product' do
            cart_item = user.add_cart_item(product: product, quantity: 3)
            cart_item = user.add_cart_item(product: other_product, quantity: 3)
            expect(user.cart_items.length).to eq(2)
        end
    end
end