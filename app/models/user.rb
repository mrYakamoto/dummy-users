class User < ActiveRecord::Base
  # setter and getter for hashed pword
  def password=(password)
    self.hashed_password = BCrypt::Password.create(password)
  end

  def password
    BCrypt::Password.new(self.hashed_password)
  end
end
