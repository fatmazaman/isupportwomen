class CreateEmpowers < ActiveRecord::Migration
  def change
    create_table :empowers do |t|
      t.string :title
      t.text :description
      t.string :category
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
