class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, :precision => 10, :scale => 2
      t.integer :inventary
      t.text :description

      t.timestamps
    end
  end
end
