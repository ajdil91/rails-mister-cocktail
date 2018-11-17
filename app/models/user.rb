class User < ApplicationRecord
  has_many :cocktails, dependent: :destroy
  has_many :reviews
  validates :username, presence: true, uniqueness: true
  mount_uploader :photo, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
