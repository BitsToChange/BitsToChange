class WalletGenerator
  def wallet_for_charity(charity)
    charity_node = master_node.node_for_path(path_to_charity(charity))
    Wallet.new :public_key => charity_node.to_address
  end

  private
    def master_node
      @master_node ||= MoneyTree::Node.from_serialized_address Constants::ROOT_SERIALIZED_ADDRESS
    end

    def path_to_charity(charity)
      "m/0/0/#{charity.id}"
    end
end