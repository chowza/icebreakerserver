class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :facebook_id, :age, :first_name, :latitude, :longitude, :answer1, :answer2, :answer3, :answer4, :answer5, :preferred_min_age, :preferred_max_age, :prefers_male, :preferred_sound, :preferred_distance, :image1, :image2, :image3, :image4, :image5, :male, :birthday, :access_token, :client_identification_sequence, :push_type
  has_many :matches
  has_many :messages
end
