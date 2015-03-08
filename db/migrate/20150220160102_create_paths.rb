class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.string :name
      t.belongs_to :empower, index: true

      t.timestamps null: false
    end
    add_foreign_key :paths, :empowers
  end
end
