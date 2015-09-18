class AuthGroup < ActiveRecord::Base
  has_many :auth_memberships
  has_many :users, through: :auth_memberships
end
