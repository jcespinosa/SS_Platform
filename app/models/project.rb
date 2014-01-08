class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_files, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  before_create :create_project_hash
  before_create :set_project_status

  validates :name,
            presence: true,
            length: { maximum: 50 }

  validates :description,
            presence: true, 
            length: { maximum: 300 }

  validates :user_id, 
            presence: true

  def Project.new_hash
    SecureRandom.urlsafe_base64(8)
  end

  private
    def create_project_hash
      self.project_hash = Project.new_hash
      path = File.path("#{Rails.root}/tmp/users/#{user.user_hash}/#{self.project_hash}/")
      FileUtils.mkdir_p(path) unless File.exists?(path)
    end

    def set_project_status
      self.status = "Nuevo"
      self.progress = 0
    end
end
