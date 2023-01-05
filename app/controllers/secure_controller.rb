class SecureController < ApplicationController
    include JsonWebToken

    attr_reader :allowed_roles

    def initialize
        super
        @allowed_roles = init_roles
    end

    before_action :authorize

    def self.allow_roles(*roles)
        @allowed_roles = roles
    end

    def self.allowed_roles
        @allowed_roles ||= []
    end

    protected
    
    def current_user
        @current_user ||= User.find_by email: @token_decoded.email, role: @token_decoded.role
    end

    def authorize
        begin
            token = request.headers['Authorization']&.split(' ')&.last
            @token_decoded = decode_jwt(token)
        rescue => e
            render json: { message: 'Not provided or invalid token' }, status: :unauthorized
            return
        end
        
        if @token_decoded.nil? || current_user.nil? || !@allowed_roles.include?(current_user.role)
            render json: { message: 'Not allowed' }, status: :forbidden
        end
    end
    
    private

    def init_roles
        current_class = self.class
        loop do
            break if current_class.nil? || current_class.superclass.nil? || (defined?(current_class.allowed_roles) && current_class.allowed_roles.any?)
            current_class = current_class.superclass
        end
        defined?(current_class.allowed_roles) ? current_class.allowed_roles : []
    end
end
