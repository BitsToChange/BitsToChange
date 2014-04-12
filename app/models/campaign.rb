class Campaign < ActiveRecord::Base
  belongs_to :charity
  has_many :wallets, :as => :walletable

  validates_presence_of :name
  validates_size_of :name, maximum: 100

  validates_presence_of :description
  validates_size_of :description, maximum: 5000

  validates_presence_of :goal
  validates :goal, numericality: {
      only_integer: true,
      less_than: 1000000000, # One billion
      greater_than: 0
  }
end
