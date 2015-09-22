class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :firstname, presence: true,
                   length: {maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :username, presence: true,
                   length: { maximum: 42 },
                   uniqueness: { case_sensitive: false }
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" } 
  #has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
                               size: { less_than: 3.megabytes }

  has_secure_password
  validates :password, presence: true,
                       length: { minimum: 8 },
                       allow_nil: true

  
  has_many :auth_memberships
  has_many :auth_groups, through: :auth_memberships

  accepts_nested_attributes_for :auth_memberships,
                                :reject_if => :all_blank,
                                :allow_destroy => true
  accepts_nested_attributes_for :auth_groups

  
  has_many :recipes
end
