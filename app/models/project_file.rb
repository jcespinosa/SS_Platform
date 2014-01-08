class ProjectFile < ActiveRecord::Base
  belongs_to :project
  has_attached_file :attachment
  default_scope -> { order('created_at DESC') }
  before_create :create_file_hash

  validates :name,
            presence: true,
            length: { maximum: 50 }

  validates :description,
            presence: true, 
            length: { maximum: 300 }

  validates :project_id, 
            presence: true

  validates_attachment_presence :attachment

  def ProjectFile.new_hash
    SecureRandom.urlsafe_base64(8)
  end

  private
    def create_file_hash
      self.file_hash = ProjectFile.new_hash
    end

end
