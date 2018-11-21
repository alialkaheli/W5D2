class Sub < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  belongs_to :user,
  class_name: :User,
  foreign_key: :moderator_id

  has_many :post_subs

  has_many :post,
  through: :post_subs,
  source: :post
end
