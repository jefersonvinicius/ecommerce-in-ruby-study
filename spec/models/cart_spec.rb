require 'rails_helper'

RSpec.describe 'Cart' do
    
    context 'creating' do
        let(:user) do
            user_created = create_fake_user!
            5.times { user_created.add_cart_item product: create_fake_product! }
            user_created
        end

        it 'cart items' do
            expect(user.cart.items.length).to eq(5)
        end
    end

    context 'total' do
        let(:user) do
            user_created = create_fake_user!
            user_created.add_cart_item product: create_fake_product!(price: 20.50), quantity: 2
            user_created.add_cart_item product: create_fake_product!(price: 10), quantity: 4
            user_created.add_cart_item product: create_fake_product!(price: 100.99), quantity: 2
            user_created
        end

        it 'calculate correct' do
           expect(user.cart.total).to eq(282.98)
        end
    end
end