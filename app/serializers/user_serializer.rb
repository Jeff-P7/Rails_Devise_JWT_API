class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :email, :bio, :firstName, :lastName
end
