class User < ActiveRecord::Base 
  has_many :projects, dependent: :destroy

  has_attached_file :attachment, 
                    :styles => { 
                      :medium => "200x200>", 
                      :thumb => "80x80>" 
                    }, 
                    :url => "/public/users/:style/missing.png"

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create :create_user_hash

  validates :name,
            presence: true, 
            length: { maximum: 50 }

  #EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  USERNAME_REGEX = /\A(?![_. ])(?!.*[_. ]{2})[a-zA-Z0-9._-]+(?<![_. ])+\z/

  validates :username,
            presence: true,
            format: { with: USERNAME_REGEX },
            uniqueness: true,
            length: { minimum: 6, maximum: 18 }

  validates :email,
            presence: true,
            format: { with: EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password,
            length: { minimum: 6 },
            if: :password

  validates_attachment :attachment,
                       :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] },
                       :size => { :in => 0..5.megabytes },
                       if: :attachment

  def User.new_token(length)
    SecureRandom.urlsafe_base64(length)
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_token(16))
    end

    def create_user_hash
      self.user_hash = User.new_token(8)
      path = File.path("#{Rails.root}/tmp/users/#{self.user_hash}/")
      FileUtils.mkdir_p(path) unless File.exists?(path)
    end

end