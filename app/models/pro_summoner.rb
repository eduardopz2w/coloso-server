class ProSummonerValidator < ActiveModel::Validator
  def validate(record)
    urid = record.summonerId

    begin
      summonerData = RiotClient.fetchSummonerByUrid(urid)
      record.accountId = summonerData[:accountId]
    rescue EntityNotFoundError
      record.errors[:summonerId] = "El id no corresponde a ninguna cuenta"
    rescue RiotServerError
      record.errors[:summonerId] = "No se ha podido obtener datos de la cuenta desde los servidores de riot, intente más tarde"
    end
  end
end

class ProSummoner < ApplicationRecord
  validates :summonerId, presence: true, uniqueness: true, :format => { :with => /\A(BR|EUNE|EUW|JP|KR|LAN|LAS|NA|OCE|RU|TR)_/, :message => "Debe anteponer la region"}
  validates_with ProSummonerValidator

  belongs_to :pro_player
  has_many :pro_builds, :dependent => :destroy

  before_create do
    self.lastCheck = (DateTime.now() - 30).strftime('%Q')
  end
end
