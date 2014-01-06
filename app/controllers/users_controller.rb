class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)    # Not the final implementation!
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(edit_user_params)
      flash[:success] = 'Perfil actualizado correctamente'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    path = "#{Rails.root}/tmp/users/#{@user.user_hash}/tmp.tmp"
    dir = File.dirname(path)
    FileUtils.rm_rf(dir)
    User.find(params[:id]).destroy
    flash[:success] = dir
    redirect_to users_url
  end

  def projects
    @user = User.find(params[:id])
    @projects = @user.projects
  end

  private
    def new_user_params
      params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
    end

    def edit_user_params
      params.require(:user).permit(:email, :speciality, :job, :workplace, :about, :degree, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
