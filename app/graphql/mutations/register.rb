module Mutations
  require 'pry'
  class Register < BaseMutation
    graphql_name 'Register'

    # class AuthProviderSignupData < Types::BaseInputObject
    #   argument :credentials, Types::AuthProviderCredentialsInput, required: false
    # end

    # often we will need input types for specific mutation
    # in those cases we can define those input types in the mutation class itself
    argument :name, String, required: true
    # argument :auth_provider, AuthProviderSignupData, required: false
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false

    def resolve(**args)
      user = User.create!(
        name: args[:name],
        email: args[:email],
        password: args[:password]
      )
      {
        user: user
      }
    end
  end
end
