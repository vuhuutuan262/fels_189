class CreateLessonWords < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_words do |t|
      t.references :lesson, index: true, foreign_key: true
      t.references :word, index: true, foreign_key: true

      t.timestamps
    end
  end
end
