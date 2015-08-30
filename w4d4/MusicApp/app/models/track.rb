# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  track_name :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lyrics     :text             not null
#  track_type :string           not null
#

class Track < ActiveRecord::Base
  TRACK_TYPES = ["bonus", "regular"]
  validates :album_id, :track_name, :lyrics, presence: true
  validates :track_type, inclusion: TRACK_TYPES

  belongs_to :album
  has_many :notes, dependent: :destroy
end
