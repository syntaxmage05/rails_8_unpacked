class Message < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :content, presence: true, length: { maximum: 1_000 }

  after_create_commit :broadcast_message

  def broadcast_message
    broadcast_replace_to(
      [ task, "messages" ],
      target: "messages_list",
      partial: "messages/list",
      locals: { messages: task.messages.includes(:user).order(created_at: :desc) }
    )

    broadcast_replace_to(
      [ task, "messages" ],
      target: "message_count",
      partial: "messages/count",
      locals: { count: task.messages.count }
    )
  end
end
