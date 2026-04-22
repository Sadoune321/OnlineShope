package infrastructure.adapter;

import domain.model.Product;
import domain.port.IProductRepository;
import infrastructure.persistence.ProductEntity;
import infrastructure.persistence.ProductMapper;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


@Stateless
public class ProductRepositoryJPA implements IProductRepository {

    @PersistenceContext(unitName = "MinishopPU")
    private EntityManager em;

    @Override
    public Product findById(Long id) {
        ProductEntity e = em.find(ProductEntity.class, id);
        if (e == null) throw new IllegalArgumentException("Produit introuvable: " + id);
        return ProductMapper.toDomain(e);
    }

    @Override
    public Optional<Product> findByIdOptional(Long id) {
        return Optional.ofNullable(ProductMapper.toDomain(em.find(ProductEntity.class, id)));
    }

    @Override
    public List<Product> findAvailable() {
        return em.createQuery(
                "SELECT p FROM ProductEntity p WHERE p.available = true " +
                "AND p.quantityOnHand > 0 ORDER BY p.description", ProductEntity.class)
            .getResultList().stream()
            .map(ProductMapper::toDomain)
            .collect(Collectors.toList());
    }

    @Override
    public List<Product> findAll() {
        return em.createQuery("SELECT p FROM ProductEntity p ORDER BY p.id", ProductEntity.class)
            .getResultList().stream()
            .map(ProductMapper::toDomain)
            .collect(Collectors.toList());
    }

    @Override
    public boolean isOrderable(Long id) {
        return findByIdOptional(id).map(Product::isOrderable).orElse(false);
    }
}