require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:product) { Product.create(name: "Any", price: 105) }
  
  it 'total calculation' do
    cart_item = CartItem.create(product: product, quantity: 3)
    expect(cart_item.total).to eq(315)
  end
end
