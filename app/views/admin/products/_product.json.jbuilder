json.product do
    json.id @product.id
    json.name @product.name
    json.description @product.description
    json.inventary @product.inventary
    json.image_url @product.image.url
    json.price @product.price
    json.created_at @product.created_at
    json.updated_at @product.updated_at
end