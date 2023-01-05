module Factories
    def create_fake_user(args = {})
        User.new(fake_user_params.merge(args))
    end

    def create_fake_user!(args = {})
        User.create!(fake_user_params.merge(args))
    end

    def create_fake_product(args = {})
        Product.new(fake_product_params.merge(args))
    end

    def create_fake_product!(args = {})
        Product.create!(fake_product_params.merge(args))
    end

    private

    def fake_user_params
        {
            name: 'Any name',
            email: 'anyemail@gmail.com',
            password: '123456',
            role: Roles::CLIENT
        }
    end

    def fake_product_params
        {
            name: 'Any product',
            price: 10
        }
    end
end