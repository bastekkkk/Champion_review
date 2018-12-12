class Champion < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews

  has_attached_file :champion_img, styles: { champion_index: "100x100>", champion_show: "325x475>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :champion_img, content_type: /\Aimage\/.*\z/


end
