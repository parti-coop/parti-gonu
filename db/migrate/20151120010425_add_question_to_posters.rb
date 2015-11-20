class AddQuestionToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :question, :text, default: '찬반 질문을 던져주세요.'

    reversible do |dir|
      dir.up do
        change_column_default :posters, :question, nil
        change_column_null :posters, :question, false
      end
    end
  end
end
