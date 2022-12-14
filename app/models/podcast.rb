class Podcast < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :episodes

  has_one_attached :thumbnail
  # has_attached_file :thumbnail, :styles => { :large => "1000x1000#", :medium => "550x550#" }
  # validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/
end
