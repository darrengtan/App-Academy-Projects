class List < ActiveRecord::Base
  validates :title, :board, :ord, presence: true
  belongs_to :board
  has_many :cards

  def new_card_ord
    self.cards.length + 1
  end
end
