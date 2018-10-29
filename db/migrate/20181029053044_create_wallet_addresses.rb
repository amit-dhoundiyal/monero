class CreateWalletAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :wallet_addresses do |t|
      t.string :integrated_address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
