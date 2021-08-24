class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :content, null: true
      t.integer :quantity, null: false
      t.float :price, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
