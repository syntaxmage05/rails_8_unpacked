class Task < ApplicationRecord
  enum :status, {
    in_progress: "in_progress",
    completed: "completed",
    archived: "archived"
  }

  scope :active, -> { where(status: [:in_progress, :completed]) }
end
