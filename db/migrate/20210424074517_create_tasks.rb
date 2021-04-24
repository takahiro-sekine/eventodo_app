class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :task_title, null: false
      t.text :state
      t.datetime :complete
      t.references :user 
      t.timestamps

    end
  end
end
