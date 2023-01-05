class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.belongs_to :product, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :quantity
      t.boolean :enabled

      t.timestamps
    end
  end
end
