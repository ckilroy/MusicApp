class User < ActiveRecord::Base
  #don't forget to have it inherit from ActiveRecord::Base

  # validates :email, :password_digest, :session_token, presence: true
  attr_reader :password

  validates :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
    #finds user instance by email first. return nil if no user with that email.
    #calls *User#is_password?* on user instance, which checks this user's saved
    #password_digest against the password string given.
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    #need to call generate_session_token on *class User*.
    #self.class.generate_session_token to generate a new token
    self.save!
    self.session_token
    #remember that reset_session_token doesn't just set the session token, but
    #saves the user with the new session_token and then returns the session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
    #self.session_token || self.session_toke = self.class.generate_session_token
    #checks if there is a session token, if not, sets it to a new session token
    #run this after initialize and before validations above
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    #create a password digest ny encrypting the given password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
    #checks if the password generated from the saved password digest the same as the password string
  end

end
