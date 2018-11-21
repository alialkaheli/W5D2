class User < ApplicationRecord
  validates :username, :session_token, uniqueness: true, presence: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true }

  attr_reader :password
  after_initialize :ensure_token

  has_many :subs
  has_many :posts

  def ensure_token
    self.session_token ||= SecureRandom.urlsafe_base64

  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.isPass(password) ? user : nil
  end

  def isPass(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
