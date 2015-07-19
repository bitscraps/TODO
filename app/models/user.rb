class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  validates_presence_of :username, :password
  validates_uniqueness_of :username
  validates_confirmation_of :password

  before_save :hash_new_password

  private
  def hash_new_password
    self.hashed_password = BCrypt::Password.create(self.password)
  end
end
