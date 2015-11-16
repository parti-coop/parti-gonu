class AddChoiceToStands < ActiveRecord::Migration
  def change
    add_column :stands, :choice, :integer
  end
end
