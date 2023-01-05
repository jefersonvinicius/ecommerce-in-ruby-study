module Admin
    class BaseController < SecureController
        allow_roles Roles::ADMIN, Roles::SUPER_ADMIN
    end
end