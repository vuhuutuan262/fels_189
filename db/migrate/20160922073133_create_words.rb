class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.integer :categories_id

      t.timestamps
    end
  end
end
