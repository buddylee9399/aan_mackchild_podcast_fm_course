class Episode < ApplicationRecord
  belongs_to :podcast
  has_one_attached :episode_thumbnail
  # has_attached_file :episode_thumbnail, :styles => { :large => "1000x1000#", :medium => "550x550#" }
  # validates_attachment_content_type :episode_thumbnail, :content_type => /\Aimage\/.*\Z/

  has_one_attached :mp3_file
  # has_attached_file :mp3
  # validates_attachment :mp3, :content_type => { :content_type => ["audio/mpeg", "audio/mp3"] }, :file_name => { :matches => [/mp3\Z/] }
end
