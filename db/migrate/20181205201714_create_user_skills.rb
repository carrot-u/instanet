class CreateUserSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :user_skills do |t|
      t.references :user, foreign_key: {to_table :users}
      t.string :name
      t.integer :level
      t.boolean :active

      t.timestamps
    end
  end
end
