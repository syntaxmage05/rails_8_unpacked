class MessagesController < ApplicationController
  before_action :set_task

  def create
    @message = @task.messages.build(message_params)
    @message.user = Current.user
    @messages = task_messages

    if @message.save
      @messages = task_messages
      @created_message = @message
      @message = @task.messages.build
      @message_notice = "Message sent."

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to task_path(@task), notice: @message_notice }
      end
    else
      @message_notice = nil

      respond_to do |format|
        format.turbo_stream { render :create, status: :unprocessable_content }
        format.html { render "tasks/show", status: :unprocessable_content }
      end
    end
  end

  private

  def set_task
    @task = Current.user.group.tasks.find(params[:task_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def task_messages
    @task.messages.includes(:user).order(created_at: :desc)
  end
end
