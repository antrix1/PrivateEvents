class EventsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]

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
    @events = Event.paginate(page: params[:page], per_page: 4)
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
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
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "Event deleted successfully"
      redirect_to events_path
    else
      flash[:danger] = "Could not delete"
      render @event
    end
  end

  def attend
    @event = Event.find(params[:id])
    @invitation = current_user.invitations.build(event_id: @event.id)
    if @invitation.save
      flash[:success] = "You are now attending this event"
      redirect_to @event
    else
      flash[:danger] = "Something went wrong"
      render :show
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :location, :event_date, :event_time)
  end
end
