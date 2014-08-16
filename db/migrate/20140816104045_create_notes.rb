class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :user, index: true
      t.string :url
      t.string :title
      t.text :summary

      t.timestamps
    end
  end
end
