class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    if params[:range] == "User"
      @users = User.looks(params[:search], params[:word])
    elsif params[:range] == "Book"
      @books = Book.looks(params[:search], params[:word])
    else
      @books = Book.includes(:book_tags).where(book_tags: { tag: params[:word] })
    end
  end

  def datesearch
    @user = User.find(params[:date_search][:user_id])
    @date = params[:date_search][:created_at].to_datetime
    @books = @user.books.created_on(@date)
  end
end
