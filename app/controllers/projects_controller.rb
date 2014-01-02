class ProjectsController < ApplicationController
  before_action :signed_in_user, only: [:new, :edit, :create, :destroy]
  before_action :correct_user, only: [:edit, :destroy]
  #before_action :correct_user, only: [:edit, :update]

  def index
  end

  def new
    @project = current_user.projects.build if signed_in?
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = current_user.projects.build(new_project_params)
    if @project.save
      flash[:success] = "Nuevo proyecto generado: #{@project.name}"
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(edit_project_params)
      flash[:success] = 'Proyecto actualizado correctamente'
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    path = "#{Rails.root}/tmp/users/#{current_user.user_hash}/#{@project.project_hash}/tmp.tmp"
    dir = File.dirname(path)
    FileUtils.rm_rf(dir)
    flash[:success] = "Se eliminó el proyecto #{@project.name}"
    @project.destroy
    redirect_to current_user
  end

  private
    def new_project_params
      params.require(:project).permit(:name, :description)
    end

    def edit_project_params
      params.require(:project).permit(:description)
    end

    def correct_user
      @project = current_user.projects.find_by(id: params[:id])
      redirect_to current_user if @project.nil?
    end
end
