module V1
  class ProPlayerSerializer < ActiveModel::Serializer
    attributes :id, :name, :imageUrl, :realName, :role
  end
end
