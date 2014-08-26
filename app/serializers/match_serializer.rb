class MatchSerializer < ActiveModel::Serializer
  attributes :id, :swipee_id, :likes, :match, :swiper_name, :swipee_name, :profile_id
end
