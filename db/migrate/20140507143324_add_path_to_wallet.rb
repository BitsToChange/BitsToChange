class AddPathToWallet < ActiveRecord::Migration
  def change
    add_column :wallets, :path, :string

    reversible do |dir|
      dir.up do
        Wallet.reset_column_information

        wallets = Wallet.all
        wallets.each do |wallet|
          if (wallet.walletable.kind_of?(Charity))
            wallet.path = WalletGenerator.new.path_to_charity(wallet.walletable)
          elsif (wallet.walletable.kind_of?(Campaign))
            wallet.path = WalletGenerator.new.path_to_campaign(wallet.walletable)
          end
          wallet.save
        end
      end
    end

  end
end
