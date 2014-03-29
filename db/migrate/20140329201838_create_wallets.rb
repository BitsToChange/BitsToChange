class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.string :public_key
      t.references :walletable, polymorphic: true

      t.timestamps
    end
  end
end
