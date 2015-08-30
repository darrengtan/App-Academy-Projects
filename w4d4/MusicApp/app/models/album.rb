# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  album_name :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_type :string           not null
#

class Album < ActiveRecord::Base
  ALBUM_TYPES = ["LIVE", "STUDIO"]
  validates :band_id, :album_name, presence: true
  validates :album_type, inclusion: ALBUM_TYPES

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
