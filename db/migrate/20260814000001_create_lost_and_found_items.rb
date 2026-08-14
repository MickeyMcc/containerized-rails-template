class CreateLostAndFoundItems < ActiveRecord::Migration[8.1]
  def change
    create_table :lost_and_found_items do |t|
      t.references :reported_by_user, foreign_key: { to_table: :users }
      t.references :found_by_user, foreign_key: { to_table: :users }, null: true
      t.string :title
      t.text :description
      t.string :location
      t.string :status, default: "unfound"

      t.timestamps
    end

    add_index :lost_and_found_items, :status
  end
end
