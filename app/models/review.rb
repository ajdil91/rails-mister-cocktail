class Review < ApplicationRecord
  belongs_to :cocktail

  # RATINGS = ["★", "★★", "★★★", "★★★★", "★★★★★"]
  RATINGS = [1, 2, 3, 4, 5]

  validates :content, presence: true
  validates :rating, inclusion: { in: RATINGS }
end
