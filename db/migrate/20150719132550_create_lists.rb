class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.string :name
      t.boolean :archived

      t.timestamps null: false
    end
  end
end
