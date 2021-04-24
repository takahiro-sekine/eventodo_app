class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    if @event.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @event.comments.includes(:user)
  end

  def edit
    redirect_to action: :index unless current_user.id == @event.user_id
  end

  def update
    if @event.update(event_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @event.user_id
      @event.destroy
      redirect_to root_path
    else
      redirect_to action: :index
    end
  end

  def search
    @events = Event.search(params[:keyword])
  end

  private

  def event_params
    params.require(:event).permit(:title, :limit_date, :limit_time, :body).merge(user_id: current_user.id)
  end

  def set_item
    @event = Event.find(params[:id])
  end
end
