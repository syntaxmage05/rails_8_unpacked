class Task < ApplicationRecord
  belongs_to :group

  enum :status, {
    in_progress: "in_progress",
    completed: "completed",
    archived: "archived"
  }

  scope :active, -> { where(status: [:in_progress, :completed]) }
end
