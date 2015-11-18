class AddStandToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :stand, index: true
    remove_reference :comments, :version
  end
end
