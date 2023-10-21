class BookSortsController < ApplicationController

  def goods
    @books = Book.includes(:favorited_users)
             .sort_by { |book| -book.favorited_users.count }
  end

  def comments
    @books = Book.includes(:book_comments).sort_by { |book| -book.book_comments.count }
  end

  def visits
    @books = Book.includes(:foot_stamps).sort_by { |book| -book.foot_stamps.count }
  end

  def star
    @books = Book.all.sort_by { |book| -book.star.to_i }
  end

end
