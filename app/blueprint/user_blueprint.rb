class UserBlueprint < Blueprinter::Base
  identifier :id
  fields :firstName, :lastName, :bio, :email, :username

  # FIXME: Please change the camel case naming convention to underscore

  view :auth_user do
    fields :firstName, :lastName, :bio, :email, :username
  end

  view :normal do
    fields :first_name, :last_name
  end

  view :extended do
    include_view :normal
    # field :address
    # association :projects
  end

  view :account do
    field :username
  end
end
