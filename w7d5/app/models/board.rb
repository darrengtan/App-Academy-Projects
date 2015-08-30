class Board < ActiveRecord::Base
  validates :title, :user, presence: true

  belongs_to :user
  has_many :lists
  has_many :cards, through: :lists, source: :cards

  def new_list_ord
    self.lists.length + 1
  end
end
