class ProPlayer < ApplicationRecord
  has_many :pro_summoners, :dependent => :destroy

  validates :name, :imageUrl, :realName, :role, presence: true
  validates :role, :format => { :with => /(top|mid|jungle|adc|sup|comodin)/, :message => "No es un rol valido"}

  before_create do
    self.imageUrl = "http://www.coloso.net/images/pros/#{self.name.sub(/ /, '_').downcase()}"
  end
end
