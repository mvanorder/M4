class Recipe < ActiveRecord::Base
  validates :name, presence: true,
                   length: { minimum: 5 }

  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
                               size: { less_than: 3.megabytes }


  has_many :recipe_ingredients, :dependent => :destroy
  has_many :ingredients, through: :recipe_ingredients

  accepts_nested_attributes_for :recipe_ingredients,
                                :reject_if => :all_blank,
                                :allow_destroy => true
  accepts_nested_attributes_for :ingredients


  belongs_to :user
end
