class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :description, null: true
      t.integer :parent_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
