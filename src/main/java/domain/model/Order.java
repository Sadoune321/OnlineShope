package domain.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Order implements Serializable {

    private Long           id;
    private List<CartItem> items;
    private double         total;
    private LocalDateTime  createdAt;
    private OrderStatus    status;

    public enum OrderStatus { PENDING, CONFIRMED, CANCELLED }

    public Order(List<CartItem> items) {
        if (items == null || items.isEmpty())
            throw new IllegalArgumentException("Une commande doit contenir au moins un article.");
        this.items     = new ArrayList<>(items);
        this.total     = items.stream().mapToDouble(CartItem::getSubtotal).sum();
        this.createdAt = LocalDateTime.now();
        this.status    = OrderStatus.PENDING;
    }

    public void confirm() { this.status = OrderStatus.CONFIRMED; }
    public void cancel()  { this.status = OrderStatus.CANCELLED; }

    public Long           getId()        { return id;                                  }
    public List<CartItem> getItems()     { return Collections.unmodifiableList(items); }
    public double         getTotal()     { return total;                               }
    public LocalDateTime  getCreatedAt() { return createdAt;                           }
    public OrderStatus    getStatus()    { return status;                              }
    public int            getItemCount() { return items.size();                        }
    public void           setId(Long id) { this.id = id;                              }
}