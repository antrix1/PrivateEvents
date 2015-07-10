class Event < ActiveRecord::Base

  # Associations

  belongs_to :creator, class_name: User
  has_many :attendees, class_name: Invitation, foreign_key: :event_id

  ####################################
end
