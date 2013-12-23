class Project < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  before_create :create_project_hash

  validates :name,
            presence: true,
            length: { maximum: 50 }

  validates :description,
            presence: true, 
            length: { maximum: 256 }

  validates :user_id,
            presence: true

  def Project.new_hash
    SecureRandom.urlsafe_base64(8)
  end

  private
    def create_project_hash
      self.hash = Project.new_hash
    end
end
