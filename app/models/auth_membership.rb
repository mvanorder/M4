class AuthMembership < ActiveRecord::Base
  belongs_to :users
  belongs_to :auth_groups
end
