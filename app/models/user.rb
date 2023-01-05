class User < ApplicationRecord
    include ActiveModel::SecurePassword

    has_many :cart_items

    has_secure_password
    
    validates :name, presence: true, length: { maximum: 255 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
    validates :password, presence: true, length: { minimum: 6 }
    validates :role, presence: true

    def is_admin?
        [Roles::ADMIN, Roles::SUPER_ADMIN].include? role
    end

    def is_client?
        role == Roles::CLIENT
    end

    def add_cart_item(product:, quantity: 1)
        cart_item = self.cart_items.where(product_id: product.id).first
        if cart_item.nil?
            cart_item = CartItem.create!(product: product, quantity: quantity, enabled: true, user: self)
            self.cart_items << cart_item
        else
            cart_item.quantity += quantity
            cart_item.save!
        end
        cart_item
    end

    def cart
        Cart.new self
    end
end
