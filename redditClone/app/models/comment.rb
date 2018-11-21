class Comment < ApplicationRecord
  validates :body, presence: true

  after_initialize :ensure_post!

  belongs_to :post
  belongs_to :user

  belongs_to :parent,
  foreign_key: :parent_id,
  class_name: :Comment

  has_many :child,
  foreign_key: :parent_id,
  class_name: :Comment

  def ensure_post!
    self.post_id ||= self.parent_comment.post_id if parent_comment
  end
end
