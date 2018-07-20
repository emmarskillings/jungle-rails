class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates :name, presence: true
  validates :email, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

end
