class BooksController < ApplicationController
before_action :is_matching_login_book_user, only: [:edit, :update]

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.new
    @show_book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:notice] = "successfully"
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_book_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end

end
