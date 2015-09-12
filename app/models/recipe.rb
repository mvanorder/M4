class Recipe < ActiveRecord::Base
  validates :name, presence: true,
                   length: { minimum: 5 }
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
                               size: { less_than: 3.megabytes }
end
