class ProSummoner < ApplicationRecord
  belongs_to :pro_player
  has_many :pro_builds
end
