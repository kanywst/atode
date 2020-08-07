class UsersController < ApplicationController
  before_action :logged_in_user,only: [:index,:edit,:update,:destroy]
  before_action :correct_user, only:[:edit,:update]
  before_action :admin_user, only: [:index,:destroy]

  def show
    @user = User.find_by(username: params[:username])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find_by(username: params[:username]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welecome to Atode!"
      redirect_to user_path(@user.username)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(username: params[:username])
  end

  def update
    @user = User.find_by(username: params[:username])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name,:username,:email,:password,:password_confirmation)
    end
    
    def correct_user
      @user = User.find_by(username: params[:username])
      redirect_to(root) unless @user == current_user
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
