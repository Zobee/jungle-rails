class User < ActiveRecord::Base
  def self.authenticate_with_credentials(email, password)
    user = User.where("lower(email) = ?", email.downcase.strip).first
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
end
