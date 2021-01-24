class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # with_options present: true do
  #   validates :firstname
  #   validates :lastname
  # end

  has_one :profile
  has_many :articles, dependent: :destroy
end
