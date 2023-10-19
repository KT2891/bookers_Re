class EventNoticesController < ApplicationController
  before_action :is_owner_matching, only: [:new, :create, :edit, :update, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @event_notice = EventNotice.new
  end

  def create
    @group = Group.find(params[:group_id])
    @event_notice = EventNotice.new(event_notice_params)
    if @event_notice.save
      flash[:notice] = "successfully"
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @event_notice = Event.notice.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @event_notice = EventNotice.find(params[:id])
    if @event_notice.update(event_notice_params)
      flash[:notice] = "successfully"
      redirect_to group_path(@group)
    else
      render :update
    end
  end

  def destroy
    group = Group.find(params[:group_id])
    @event_notice = EventNotice.find_by(params[:id]).destroy
    redirect_to group_path(group)
  end

  private
  def event_notice_params
    params.require(:event_notice).permit(:title, :body, :group_id)
  end

  def is_owner_matching
    @group = Group.find(params[:group_id])
    unless @group.owner == current_user
      redirect_to group_path(@group)
    end
  end

end
