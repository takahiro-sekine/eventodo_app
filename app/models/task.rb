class Task < ApplicationRecord
  belongs_to :user, optional: true
  with_options presence: true do
    validates :task_title
    validates :complete
  end
  validate :limit_task

  private

  def limit_task
    return if complete.blank?

    errors.add(:complete, 'は今より後に設定してください') if Time.now > complete
  end
end