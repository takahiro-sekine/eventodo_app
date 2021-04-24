class Event < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :body
    validates :limit_date
  end
  validate :limit_now

  def self.search(search)
    if search != ''
      Event.where('title LIKE(?)', "%#{search}%")
    else
      Event.all
    end
  end

  private

  def limit_now
    return if limit_date.blank?

    errors.add(:limit_date, 'は今より後に設定してください') if Time.now > limit_date
  end
end
