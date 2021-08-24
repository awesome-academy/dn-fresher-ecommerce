class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :fullname, null: false
      t.string :address, null: true
      t.string :phone, null: true
      t.string :role, default: 0

      t.timestamps
    end
  end
end
