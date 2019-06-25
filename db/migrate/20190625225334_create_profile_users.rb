class CreateProfileUsers < ActiveRecord::Migration
  def change
    create_table :profile_users do |t|
      t.string :first_name
      t.string :second_name
      t.date :birthdate

      t.timestamps null: false
    end
  end
end
