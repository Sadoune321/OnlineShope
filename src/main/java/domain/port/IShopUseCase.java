package domain.port;

import domain.model.CartItem;
import domain.model.Order;
import domain.model.Product;
import java.util.List;


public interface IShopUseCase {

    
    List<Product> getAvailableProducts();
    Product getProduct(Long productId);

    
    CartItem addToCart(Long productId);
    List<CartItem> getCartItems();
    double getCartTotal();
    int getCartItemCount();
    void resetCart();

   
    Order checkout();
}