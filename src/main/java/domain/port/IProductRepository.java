package domain.port;

import domain.model.Product;
import java.util.List;
import java.util.Optional;


public interface IProductRepository {
    Product findById(Long id);
    Optional<Product> findByIdOptional(Long id);
    List<Product> findAvailable();
    List<Product> findAll();
    boolean isOrderable(Long id);
}