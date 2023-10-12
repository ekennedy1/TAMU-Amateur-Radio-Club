class User < ApplicationRecord
<<<<<<< HEAD
    has_many :books, through: :user_books
    has_many :user_books
=======
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :fname, :lname, :role, presence: true
  def admin?
    role == 'Admin'
  end
>>>>>>> editTest
end
