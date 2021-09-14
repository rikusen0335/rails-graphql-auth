module Mutations
  class Register < BaseMutation
    graphql_name 'Register'

    field :id, Integer, null: false
    field :token, String, null: false
    field :result, Boolean, null: true

    argument :email, String, required: true
    argument :password, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true

    def resolve(**args)
      user = context[:current_user]
      if user.present?
        GraphQL::ExecutionError.new("You are already logged-in.")
      end

      user = User.create!(
        email: args[:email],
        password: args[:password],
        first_name: args[:first_name],
        last_name: args[:last_name]
      )

      if user.present?
        context[:current_user] = user
        {
          id: user.id,
          token: "test_token",
          result: true
        }
      end
    end
  end
end
