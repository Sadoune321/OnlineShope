package domain.service;

import domain.model.CartItem;
import domain.model.Order;
import domain.model.Product;
import domain.port.ICartRepository;
import domain.port.IOrderRepository;
import domain.port.IProductRepository;
import domain.port.IShopUseCase;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import java.util.List;


@Stateless
public class ShopService implements IShopUseCase {

    @EJB
    private IProductRepository productRepository;
    @EJB
    private ICartRepository cartRepository;
    @EJB
    private IOrderRepository orderRepository;

    @Override
    public List<Product> getAvailableProducts() {
        return productRepository.findAvailable();
    }

    @Override
    public Product getProduct(Long productId) {
        return productRepository.findById(productId);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public CartItem addToCart(Long productId) {
        if (!productRepository.isOrderable(productId)) {
            throw new IllegalStateException(
                "Le produit " + productId + " n'est pas disponible ou est hors stock."
            );
        }
        Product p = productRepository.findById(productId);
        CartItem item = new CartItem(p.getId(), p.getDescription(), p.getPurchaseCost(), 1);
        cartRepository.addItem(item);

        
        productRepository.decrementStock(productId);

        return item;
    }

    @Override
    public List<CartItem> getCartItems()  { return cartRepository.getItems();     }
    @Override
    public double getCartTotal()          { return cartRepository.getTotal();     }
    @Override
    public int getCartItemCount()         { return cartRepository.getItemCount(); }
    @Override
    public void resetCart()               { cartRepository.reset();               }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public Order checkout() {
        List<CartItem> items = cartRepository.getItems();
        if (items == null || items.isEmpty())
            throw new IllegalStateException("Le panier est vide.");
        Order order = new Order(items);
        order.confirm();
        Order saved = orderRepository.save(order);
        cartRepository.reset();
        return saved;
    }
}