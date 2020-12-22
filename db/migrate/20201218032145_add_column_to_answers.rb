class AddColumnToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :is_best_answered, :boolean, default: false
  end
end
