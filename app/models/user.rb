class User < ApplicationRecord
  # Include default devise modules. Others available  are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
        # :confirmable,
         :lockable,
         maximum_attempts: 3
  validates :name, presence: true, length: { minimum: 3 }, allow_nil: false
  has_many :comments, dependent: :destroy
  has_many :readers, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :future_readers, dependent: :destroy
end
