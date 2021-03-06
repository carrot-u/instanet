class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.integer :tier
      t.references :team, foreign_key: true
      t.string :email
      t.string :slack
      t.text :bio
      t.boolean :is_manager
      t.boolean :active

      t.timestamps
    end
  end
end
