class Book < ApplicationRecord
  has_many :users, through: :user_books
  has_many :user_books

  validates :title, presence: true
  validates :author, presence: true
  validates :price, presence: true, numericality: true
  validates :published_date, presence: true
end
