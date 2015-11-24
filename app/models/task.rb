class Task < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 200 }
  validates :priority, presence: true

end
