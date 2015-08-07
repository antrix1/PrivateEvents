class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :show, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash[:success] = "You have added a new event"
      redirect_to root_url #events_path later
    else
      flash[:danger] = "The form contains erros"
      render :new
    end
  end

  def index
    @past_events = Event.past_events.paginate(page: params[:past_events], per_page: 5)
    @upcoming_events = Event.upcoming_events.paginate(page: params[:upcoming_events], per_page: 5)
  end

  def show
  end

  def edit
  end

  def update
    @event.update_attributes(event_params)
    if @event.save
      flash[:success] = "Update successful"
      redirect_to @event
    else
      flash[:danger] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = "Event deleted successfully"
      redirect_to events_path
    else
      flash[:danger] = "Could not delete"
      render @event
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :location, :event_date, :event_time)
  end

  def correct_user
    if current_user != @event.creator
      flash[:danger] = "You don't have permission to do that."
      redirect_to root_url
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
