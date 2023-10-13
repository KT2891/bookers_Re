class UsersController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @book_info = current_user
  end

  def show
  end

  def edit
  end
end
