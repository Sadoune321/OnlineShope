package domain.port;

import domain.model.CartItem;
import java.util.List;


public interface ICartRepository {
    void addItem(CartItem item);
    List<CartItem> getItems();
    double getTotal();
    void reset();
    int getItemCount();
}