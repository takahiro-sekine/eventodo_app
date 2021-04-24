class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         with_options presence: true do
          validates :name
          validates :nickname
          validates :position
          validates :birthday
          validates :email
        end
        has_many :events, dependent: :destroy
        has_many :tasks, dependent: :destroy
        has_many :comments, dependent: :destroy
end
