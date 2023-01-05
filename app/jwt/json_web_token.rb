module JsonWebToken

    SECRET_KEY = Rails.application.credentials.jwt_secret!

    class UserTokenDecoded

        attr_reader :email, :role

        def initialize(email, role)
            @email = email
            @role = role
        end
    end

    def encode_jwt(payload)
        JWT.encode(payload, SECRET_KEY)
    end

    def decode_jwt(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        UserTokenDecoded.new(decoded['email'], decoded['role'])
    end

    def encode_access_token(user) 
        encode_jwt(user_payload(user).merge({ exp: 24.hours.from_now.to_i }))
    end

    def encode_refresh_token(user)
        encode_jwt(user_payload(user).merge({ exp: 7.days.from_now.to_i }))
    end

    private

    def user_payload(user)
        { email: user.email, role: user.role }
    end

end