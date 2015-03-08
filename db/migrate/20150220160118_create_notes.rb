class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :step
      t.belongs_to :empower, index: true

      t.timestamps null: false
    end
    add_foreign_key :notes, :empowers
  end
end
