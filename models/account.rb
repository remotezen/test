class Account < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  has_many :logins
  has_many :posts, dependent: :destroy
  has_many :comments

  # Validations
  validates_presence_of     :email,:role, :user_name,:name,:surname
  validates_presence_of     :password,                   :if => :password_required
  validates_presence_of     :password_confirmation,      :if => :password_required
  validates_length_of       :password, :within => 4..40, :if => :password_required
  validates_confirmation_of :password,                   :if => :password_required
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of       :role,     :with => /[A-Za-z]/
  validates_format_of       :user_name,     :with => /[A-Za-z]/
  validates_length_of       :user_name,   :within => 3..25
  validates_uniqueness_of   :user_name, :case_sensitive => false
  validates_uniqueness_of   :name, :case_sensitive => false


  # Callbacks
  before_save :encrypt_password, :if => :password_required

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate(email, password)
    account = first(:conditions => ["lower(email) = lower(?) or lower(user_name) = lower(?)", email, email]) if email.present?
    account && account.has_password?(password) ? account : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  private
    def encrypt_password
      self.crypted_password = ::BCrypt::Password.create(password)
    end

    def password_required
      crypted_password.blank? || password.present?
    end
    def hard_code_role
      if role.nil?
        self.role = "user"
      end
    end
end
