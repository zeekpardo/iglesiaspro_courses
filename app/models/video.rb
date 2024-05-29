class Video < ApplicationRecord
  belongs_to :course

  validates :name, :description, :youtube_id, presence: true
end
