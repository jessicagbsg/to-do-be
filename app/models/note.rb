class Note < ApplicationRecord
  has_many :todos, -> { where(deleted_at: nil) }, dependent: :destroy

  validates :title, presence: true
end
