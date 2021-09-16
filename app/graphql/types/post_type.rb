module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false

    field :posted_by, UserType, null: true, method: :user
  end
end
