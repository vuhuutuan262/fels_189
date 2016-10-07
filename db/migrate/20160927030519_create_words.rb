class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :title
      t.references :category, index: true, foreign_key: true
      t.string :picture

      t.timestamps
    end
  end
end
