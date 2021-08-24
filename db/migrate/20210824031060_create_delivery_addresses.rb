class CreateDeliveryAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address
      t.string :phone_number
      t.string :fullname

      t.timestamps
    end
  end
end
