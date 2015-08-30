# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  before_validation :ensure_session_token
  validates :username, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :cat_rental_requests,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'CatRentalRequest'
  )

  has_many(
    :cats,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Cat
  )

  has_many :session_tokens

  attr_reader :password

  def reset_session_token!
    session_token = SessionToken.new(session_token: generate_session_token, user_id: self.id)
    session_token.save!
    session_token
  end

  def ensure_session_token
    reset_session_token! if self.session_tokens.empty?
  end

  def generate_session_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end
end
