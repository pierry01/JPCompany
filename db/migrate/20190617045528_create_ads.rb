class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :title, limit: 255
      t.text :description
      t.references :admin, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
