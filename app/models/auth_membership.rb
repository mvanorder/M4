class AuthMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :auth_group
end
