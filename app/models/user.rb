class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :roles

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  def has_role?(role)
    roles.map { |singleRole| singleRole.name }.include? role
  end
end
