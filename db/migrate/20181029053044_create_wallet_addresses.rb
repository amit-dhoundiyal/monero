class CreateWalletAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :wallet_addresses do |t|
      t.string :address
      t.string :balance
      t.string :address_index
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
