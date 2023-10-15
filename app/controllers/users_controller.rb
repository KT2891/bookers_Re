class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user= current_user
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user)
    else
      render :edit
    end

  end

  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def is_matching_login_user
      user = User.find(params[:id])
      unless user == current_user
        redirect_to user_path(current_user)
      end
    end

end
