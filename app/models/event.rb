class Event < ActiveRecord::Base
  before_save :format_time

  # Associations

  belongs_to :creator, class_name: User
  has_many :invitations, foreign_key: :event_id
  has_many :attendees, through: :invitations, source: :attendee

  ###################################

  validates :name, presence: true
  validates :description, presence: true, length: {maximum: 255}
  validates :location, presence: true, length: {maximum: 30}
  validates :event_date, presence: true
  validates :event_time, presence: true

  def format_time
    date = Date.today
    self.event_time = self.event_time.to_datetime.change(day: date.day, month: date.month, year: date.year).to_time
  end
end
