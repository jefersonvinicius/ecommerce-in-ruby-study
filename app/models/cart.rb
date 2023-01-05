class Cart
    attr_reader :items

    def initialize(user)
        @items = user.cart_items.includes(:product)
    end

    def total
        @items.map{ |item| item.total }.reduce(:+)
    end
end