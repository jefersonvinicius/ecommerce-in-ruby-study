class AuthenticationController < ApplicationController
    include JsonWebToken

    def signup        
        @user = User.new(signup_params)
        if @user.save
            @access_token = encode_access_token(@user)
            @refresh_token = encode_refresh_token(@user)
            UserMailer.with(user: @user).welcome_email.deliver_later
            render 'auth'
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def login
        @user = User.find_by email: login_params[:email]
        if @user&.authenticate(login_params[:password])
            @access_token = encode_access_token(@user)
            @refresh_token = encode_refresh_token(@user)
            render 'auth'
        else
            render json: { message: "Invalid Credentials" }, status: :unauthorized
        end
    end

    private

    def signup_params
        params.permit(:name, :email, :password).merge(role: Roles::CLIENT)
    end

    def login_params
        params.permit(:email, :password)
    end
end
