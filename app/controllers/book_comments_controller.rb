class BookCommentsController < ApplicationController
  def create
    @show_book = Book.find(params[:book_id])
    @comment = current_user.book_comments.build(comments_params)
    @comment.book_id = @show_book.id
    if @comment.save
      flash[:notice] = "Successfully"
    end
  end

  def destroy
    @show_book = Book.find(params[:book_id])
    current_user.book_comments.find_by(book_id: params[:book_id]).destroy
  end

  private
    def comments_params
      params.require(:book_comment).permit(:comment)
    end
end
