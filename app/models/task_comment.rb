class TaskComment < ActiveRecord::Base
  belongs_to :task # Foreign key
  belongs_to :user

  belongs_to :recipient, class_name: 'User'

  validates :task, presence: true
  validates :user, presence: true
  validates :recipient, presence: true
  validates :comment, length: { minimum: 1, maximum: 4095, allow_blank: false }

  def new_for?(user)
    return false unless is_new
    return true if user.role != Role.student || user.role != Role.tutor
    user == recipient
  end
end
