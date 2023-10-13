class UsersController < ApplicationController
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
  end
end
