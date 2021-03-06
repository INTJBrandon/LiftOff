class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :description
      t.string :calories_burned
      t.string :length
      t.datetime :created_at
      t.integer :user_id
    end
  end
end
