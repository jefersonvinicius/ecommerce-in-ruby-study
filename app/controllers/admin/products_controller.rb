module Admin
    class ProductsController < Admin::BaseController
        def create
            @product = Product.new(product_params)
            if !@product.save
                return render json: { errors: @product.errors }, status: :unprocessable_entity
            end

            render "admin/products/_product"
        end
       
        private
    
        def product_params
            params.permit(:name, :description, :inventory, :price, :image)
        end
    end
end