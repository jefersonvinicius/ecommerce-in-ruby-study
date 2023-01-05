class PrivateController < SecureController
    allow_roles Roles::CLIENT
end