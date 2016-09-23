class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.integer :answer_id
      t.integer :words_id
      t.integer :lesson_id

      t.timestamps
    end
  end
end
