module Mutations
  class CreatePost < BaseMutation
    graphql_name 'CreatePost'

    field :post, Types::PostType, null: true
    field :result, Boolean, null: true

    argument :title, String, required: false
    argument :description, String, required: false

    def resolve(**args)
      user = context[:current_user]
      if user.present?
        post = Post.create(title: args[:title], description: args[:description])
        {
          post: post,
          result: post.errors.blank?
        }
      else
        GraphQL::ExecutionError.new("Please log-in before using mutation.")
      end
    end
  end
end
