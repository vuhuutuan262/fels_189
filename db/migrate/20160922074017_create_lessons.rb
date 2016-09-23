class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.integer :users_id
      t.integer :categories_id
      t.boolean :is_status

      t.timestamps
    end
  end
end
