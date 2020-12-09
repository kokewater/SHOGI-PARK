class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :genre_id,  null: false
      t.string :title,      null: false
      t.text :body,         null: false
      t.string :image_id

      t.timestamps
    end
  end
end
