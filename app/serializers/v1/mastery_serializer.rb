module V1
  class MasterySerializer < ActiveModel::Serializer
    type 'masteries'

    attributes :pages
  end
end
