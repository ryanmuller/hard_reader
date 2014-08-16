class AddSentAtToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :sent_at, :datetime
  end
end
