class Product < ApplicationRecord
    has_one_attached :image

    validates :name, presence: true
    validates :price, presence: true, numericality: true
    validates :description, presence: true
    validates :inventory, presence: true, numericality: { only_integer: true }
end
