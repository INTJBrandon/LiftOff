class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :name
      t.string :content
      t.datetime :created_at
      t.datetime :due_by
      t.integer :user_id
    end
  end
end
