class CreateUserBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :user_badges do |t|
      t.references :user, foreign_key: true
      t.integer :badge
      t.string :name
      t.string :src
      t.text :description
      t.boolean :active
      t.references :issued_by, foreign_key: false

      t.timestamps
    end
    add_index :user_badges, :badge
    add_foreign_key :user_badges, :users, column: :issued_by_id
  end
end
