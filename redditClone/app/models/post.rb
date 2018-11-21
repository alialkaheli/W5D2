class Post < ApplicationRecord
  validates :title, :url, :content, presence: true

  belongs_to :user
  has_many :post_subs
  
  has_many :subs,
  through: :post_subs,
  source: :sub
end
