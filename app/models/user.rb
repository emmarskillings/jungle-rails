class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => {:case_sensitive => false}
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_length_of :password, :minimum => 4

  def self.authenticate_with_credentials(email, password)

    email.strip!
    email.downcase!

    user = User.find_by_email(email)

    if user && user.authenticate(password)
      user
    else
      nil
    end

  end

end
