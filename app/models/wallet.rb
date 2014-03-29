class Wallet < ActiveRecord::Base
  belongs_to :walletable, polymorphic: true
end
