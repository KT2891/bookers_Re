class BooksController < ApplicationController
before_action :is_matching_login_book_user, only: [:edit, :update]

  def index
    today = Time.current.at_end_of_day
    weekend = (today - 6.day).at_end_of_day
    @books = Book.includes(:favorited_users)
             .sort_by { |book| -book.favorited_users.where(created_at: weekend...today).count }
    @book = Book.new
  end

  def show
    @book = Book.new
    @show_book = Book.find(params[:id])
    @book_comment = BookComment.new
    FootStamp.create(user_id: current_user.id, book_id: @show_book.id)
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
    params.require(:book).permit(:title, :body, :star)
  end

  def is_matching_login_book_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end

end
