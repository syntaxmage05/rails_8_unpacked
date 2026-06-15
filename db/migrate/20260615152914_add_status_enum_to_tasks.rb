class AddStatusEnumToTasks < ActiveRecord::Migration[8.1]
  def change
    create_enum :task_status, [:in_progress, :completed, :archived]

    change_table :tasks do |t|
      t.enum :status, enum_type: :task_status
    end
  end
end
