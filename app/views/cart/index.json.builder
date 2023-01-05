json.cart do
    json.total @cart.total
    json.items do
        json.array! @cart.items, partial: 'cart/item', as: :cart_item
    end
end