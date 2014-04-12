class Campaign < ActiveRecord::Base
  belongs_to :charity
  has_many :wallets, :as => :walletable
end
