class AddContextToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :context, :text
  end
end
