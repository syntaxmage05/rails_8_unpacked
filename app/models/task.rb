class Task < ApplicationRecord
  belongs_to :group
  has_many :messages, dependent: :destroy

  enum :status, {
    in_progress: "in_progress",
    completed: "completed",
    archived: "archived"
  }

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1_000 }
  validates :status, presence: true, inclusion: { in: statuses.keys }

  scope :active, -> { where(status: [:in_progress, :completed]) }
end
