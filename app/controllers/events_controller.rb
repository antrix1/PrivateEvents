class EventsController < ApplicationController
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

  private

  def event_params
    params.require(:event).permit(:name, :description, :location, :event_date, :event_time)
  end
end
