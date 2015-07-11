class Event < ActiveRecord::Base
  before_create :format_time

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
  validate :event_time_check
  validate :event_date_check


  def format_time
    date = Date.today
    self.event_time = self.event_time.to_datetime.change(day: date.day, month: date.month, year: date.year).to_time
  end

  def event_date_check
    event_date < Date.today ? errors.add(:event_date, "can't be in the past") : true if !event_date.nil?
  end

  def event_time_check
    if event_date == Date.today && !event_date.nil? && !event_time.nil?
      if event_time.hour < Time.now.hour
        errors.add(:event_time, "can't be in the past")
      elsif event_time.hour == Time.now.hour && event_time.min > Time.now.min
        errors.add(:event_time, "too soon to be organized")
      else
        true
      end
    end
  end
end
