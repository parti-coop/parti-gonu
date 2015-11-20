class AddQuestionToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :question, :text
  end
end
