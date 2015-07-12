class User < ActiveRecord::Base

  # Associations

  has_many :created_events, class_name: Event, foreign_key: :creator_id, :dependent => :destroy
  has_many :invitations, foreign_key: :attendee_id, :dependent => :destroy
  has_many :attended_events, through: :invitations, source: :event

###########################################################

  before_save {self.email.downcase!}
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, :format => {with: VALID_EMAIL_REGEX}, length: {maximum: 255}, uniqueness: true, if: :email_changed?
  validates :password, presence: true, length: {minimum: 8}, allow_blank: true
  has_secure_password
end
