class User < ActiveRecord::Base
  has_many :messages

  validates_presence_of :name

  scope :active, -> {
    joins(:messages).where('messages.created_at > ?', 2.minutes.ago)
  }

end
