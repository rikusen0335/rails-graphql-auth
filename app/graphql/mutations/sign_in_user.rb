module Mutations
  class SignInUser < BaseMutation
    null true

    # argument :credentials, Types::AuthProviderCredentialsInput, required: false
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(**args)
      user = User.find_by(email: args[:email])
      if user && user.authenticate(args[:password])
        token = encode(user_id: user.id)
        { token: token, user: user }
      else
        { error: "An Error Happened" }
      end
    end

    private

    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secret_key_base)
    end
  end
end
