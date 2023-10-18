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
    currentUserEntry = Entry.where(user_id: current_user.id)
    userEntry = Entry.where(user_id: @user.id)
    @book = Book.new

    # 前日比、先週日の表示用
    today = Date.today
    yesterday = Time.current.yesterday
    toweek = today - 6.day
    lastweek = toweek - 8.day
    @today_books = @user.books.where( created_at: today.beginning_of_day..today.end_of_day )
    @yesterday_books = @user.books.where( created_at: yesterday.beginning_of_day..yesterday.end_of_day )
    @toweek_books = @user.books.where( created_at: toweek.beginning_of_day..today.beginning_of_day)
    @lastweek_books = @user.books.where( created_at: lastweek.beginning_of_day..(toweek - 1.day).beginning_of_day)

    unless @user == current_user
      currentUserEntry.each do |a_user|
        userEntry.each do |b_user|
          if a_user.room_id == b_user.room_id
            @isRoom = true
            @roomId = a_user.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
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
