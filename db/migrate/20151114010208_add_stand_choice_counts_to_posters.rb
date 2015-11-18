class AddStandChoiceCountsToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :stand_actively_support_count, :integer, null: false, default: 0
    add_column :posters, :stand_in_favor_count, :integer, null: false, default: 0
    add_column :posters, :stand_oppose_count, :integer, null: false, default: 0
    add_column :posters, :stand_block_count, :integer, null: false, default: 0
  end
end
