class ProjectController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def index
  end

  def create
    @project = current_user.microposts.build(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private
    def project_params
      params.require(:project).permit(:description)
    end

end
