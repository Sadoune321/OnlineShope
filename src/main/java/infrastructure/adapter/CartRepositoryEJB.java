package infrastructure.adapter;

import domain.model.CartItem;
import domain.port.ICartRepository;
import jakarta.ejb.Stateful;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


@Stateful
public class CartRepositoryEJB implements ICartRepository, Serializable {

    private final List<CartItem> items = new ArrayList<>();
    private double total = 0.0;

    @Override
    public void addItem(CartItem newItem) {
        for (int i = 0; i < items.size(); i++) {
            CartItem existing = items.get(i);
            if (existing.getProductId().equals(newItem.getProductId())) {
                items.set(i, existing.withQuantity(existing.getQuantity() + newItem.getQuantity()));
                total += newItem.getPrice() * newItem.getQuantity();
                return;
            }
        }
        items.add(newItem);
        total += newItem.getSubtotal();
    }

    @Override
    public List<CartItem> getItems()  { return Collections.unmodifiableList(items); }

    @Override
    public double getTotal()          { return total;        }

    @Override
    public void reset()               { items.clear(); total = 0.0; }

    @Override
    public int getItemCount()         { return items.size(); }
}