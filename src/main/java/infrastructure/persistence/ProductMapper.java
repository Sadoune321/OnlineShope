package infrastructure.persistence;

import domain.model.Product;


public class ProductMapper {

    private ProductMapper() {}

    public static Product toDomain(ProductEntity e) {
        if (e == null) return null;
        return new Product(
            e.getId(), e.getDescription(), e.getPurchaseCost(),
            e.getQuantityOnHand(), e.isAvailable(), e.getProductCode()
        );
    }

    public static ProductEntity toEntity(Product d) {
        if (d == null) return null;
        ProductEntity e = new ProductEntity();
        e.setId(d.getId());
        e.setDescription(d.getDescription());
        e.setPurchaseCost(d.getPurchaseCost());
        e.setQuantityOnHand(d.getQuantityOnHand());
        e.setAvailable(d.isAvailable());
        e.setProductCode(d.getProductCode());
        return e;
    }
}