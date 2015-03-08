class AddAttachmentImageToEmpowers < ActiveRecord::Migration
  def self.up
    change_table :empowers do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :empowers, :image
  end
end
