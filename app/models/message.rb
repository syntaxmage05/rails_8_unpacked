class Message < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :content, presence: true, length: { maximum: 1_000 }
end
