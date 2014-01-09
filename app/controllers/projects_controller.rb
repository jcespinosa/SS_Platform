class ProjectsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :show, :index, :destroy]
  before_action :correct_user, only: [:edit, :update, :show, :destroy]

  def new
    @project = current_user.projects.build if signed_in?
  end

  def create
    @project = current_user.projects.build(new_project_params)
    if @project.save
      create_project
      flash[:success] = "Nuevo proyecto generado: #{@project.name}"
      redirect_to @project
    else
      render 'new'
    end
  end

  def index
  end

  def show
    @project = Project.find(params[:id])
    @project_files = @project.project_files
  end

  def edit
    @project = Project.find(params[:id])
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
    path = File.path("#{Rails.root}/tmp/users/#{current_user.user_hash}/#{@project.project_hash}/")
    FileUtils.rm_rf(path)
    flash[:success] = "Se eliminó el proyecto #{@project.name}"
    flash[:warning] = "#{path}"
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
      if @project.nil?
        flash[:warning] = 'El proyecto no existe'
        redirect_to current_user if @project.nil?
      end
    end

    def create_project
      path = File.path("#{Rails.root}/tmp/users/#{current_user.user_hash}/#{@project.project_hash}/")
      FileUtils.mkdir_p(path) unless File.exists?(path)
      flash[:warning] = "#{path}"
    end
end
