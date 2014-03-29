Before do
  @old_root_node_seed = Constants::ROOT_SERIALIZED_ADDRESS
  silence_warnings do
    Constants::ROOT_SERIALIZED_ADDRESS = MoneyTree::Master.new(seed_hex: '0123456789abcdef').to_serialized_address
  end
end

After do
  silence_warnings do
    Constants::ROOT_SERIALIZED_ADDRESS = @old_root_node_seed
  end
end