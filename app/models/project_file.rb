class ProjectFile < ActiveRecord::Base
  belongs_to :project
  default_scope -> { order('created_at DESC') }
  before_create :create_file_hash

  validates :name,
            presence: true,
            length: { maximum: 50 }

  validates :description,
            presence: true, 
            length: { maximum: 256 }

  def ProjectFile.new_hash
    SecureRandom.urlsafe_base64(8)
  end

  private
    def create_project_hash
      self.file_hash = ProjectFile.new_hash

      path = "#{Rails.root}/tmp/users/#{user.user_hash}/#{self.project_hash}/tmp.tmp"
      dir = File.dirname(path)

    end

end
