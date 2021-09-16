module Types
  require 'pry'
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :error, String, null: true
    field :posts, [Types::PostType], null: true
    def posts
      if context[:current_user].present?
        Post.all
      else
        { error: "Unauthorized" }
      end
    end

    field :post, Types::PostType, null: false do
      argument :id, Int, required: false
    end
    def post(id:)
      Post.find(id)
    end
  end
end
