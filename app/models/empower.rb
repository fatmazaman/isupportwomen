class Empower < ActiveRecord::Base
  acts_as_votable
  belongs_to :user

  has_many :comments
  
  has_many :paths
  has_many :notes

  accepts_nested_attributes_for :paths, 
                                reject_if: proc { |attributes| attributes['name'].blank? },
                                allow_destroy: true
  accepts_nested_attributes_for :notes, 
                                reject_if: proc { |attributes| attributes['step'].blank? },
                                allow_destroy: true

  validates :category, :title, :description, :image, presence: true
  
  has_attached_file :image,
  :storage => :dropbox,
  styles: { :medium => "300x300>"},
  :dropbox_credentials => Rails.root.join("config/dropbox_config.yml"),
  # :dropbox_options => { :path => proc { |style| "#{Rails.env}/#{style}/#{id}_#{image.original_filename}" } },
  :unique_filename => true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  # has_attached_file :image, styles: { :medium => "300x300>" }
  

end
