class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    t.string :address
    t.integer :address_index
    t.float   :balance

      t.timestamps
    end
  end
end
