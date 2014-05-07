class WalletGenerator
  def wallet_for_charity(charity)
    wallet_for_path(path_to_charity(charity))
  end

  def wallet_for_campaign(campaign)
    wallet_for_path(path_to_campaign(campaign))
  end

  def path_to_charity(charity)
    "m/0/0/#{charity.id}"
  end

  def path_to_campaign(campaign)
    "m/1/0/#{campaign.id}"
  end

  private
    def master_node
      @master_node ||= MoneyTree::Node.from_serialized_address Constants::ROOT_SERIALIZED_ADDRESS
    end

    def wallet_for_path(path)
      campaign_node = master_node.node_for_path(path)
      Wallet.new :public_key => campaign_node.to_address, :path => path
    end
end
