class CartController < PrivateController
    def index
        @cart = current_user.cart
    end

    def add_cart_item
        @product = Product.find params[:product_id]
        @cart_item = current_user.add_cart_item product: @product, quantity: params[:quantity] || 1
    end
end