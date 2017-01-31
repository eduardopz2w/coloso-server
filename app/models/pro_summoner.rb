class ProSummoner < ApplicationRecord
  belongs_to :pro_player
  has_many :pro_builds, :dependent => :destroy

  validates :summonerUrid, presence: true, uniqueness: true

  before_create do
    self.lastCheck = (DateTime.now() - 30).strftime('%Q')
  end
end
