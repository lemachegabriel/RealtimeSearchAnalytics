class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.string :term
      t.string :ip
      t.integer :user_id

      t.timestamps
    end
  end
end
