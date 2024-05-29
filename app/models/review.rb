class Review < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :review, presence: true
end
