class ProjectFilesController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :show, :destroy]
  before_action :correct_user, only: [:new, :create, :show]
  before_action :correct_project, only: [:edit, :update, :destroy]

  def new
    @project_file = @project.project_files.build if signed_in?
  end

  def create
    @project_file = @project.project_files.build(new_project_file_params)
    if @project_file.save
      @project.update_attribute(:status, 'En construcción')
      create_file
      flash[:success] = "El archivo se cargo correctamente: #{@project_file.name}"
      redirect_to @project
    else
      render 'new'
    end
  end

  def show
    @project_file = ProjectFile.find(params[:id])
  end

  def edit
    #@project_file = ProjectFile.find(params[:id])
  end

  def update
    #@project_file = ProjectFile.find(params[:id])
    if @project_file.update_attributes(edit_project_file_params)
      flash[:success] = 'Archivo actualizado correctamente'
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    path = File.path("#{Rails.root}/tmp/users/#{current_user.user_hash}/#{@project.project_hash}/#{@project_file.file_hash}")
    FileUtils.rm_rf(path)
    flash[:success] = "Se eliminó el archivo #{@project_file.name}"
    flash[:warning] = "#{path}"
    @project_file.destroy
    redirect_to @project
  end

  private
    def new_project_file_params
      params.require(:project_file).permit(:name, :description, :attachment)
    end

    def edit_project_file_params
      params.require(:project_file).permit(:name, :description)
    end

    def correct_user
      @project = current_user.projects.find_by(id: params[:project_id])
      if @project.nil?
        flash[:warning] = 'Esta acción no esta permitida'
        redirect_to current_user if @project.nil?
      end
    end

    def correct_project
      @project_file = ProjectFile.find(params[:id])
      @project = current_user.projects.find_by(id: @project_file.project_id)
      if @project.nil?
        flash[:warning] = 'Esta acción no esta permitida'
        redirect_to current_user if @project.nil?
      end
    end

    def create_file
      from = File.path("#{@project_file.attachment.path}")
      to = File.path("#{Rails.root}/tmp/users/#{current_user.user_hash}/#{@project.project_hash}/#{@project_file.file_hash}")
      FileUtils.mv(from, to)
      FileUtils.rm_rf(File.dirname(File.dirname("#{@project_file.attachment.path}")))
      flash[:warning] = "#{to}"
    end
end
