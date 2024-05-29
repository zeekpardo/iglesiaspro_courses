class Course < ApplicationRecord
    before_save :set_slug

    has_many :videos, dependent: :destroy
    has_many :reviews, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true

    def to_param
        slug
    end

private

    def set_slug
        self.slug = name.parameterize
    end

end
