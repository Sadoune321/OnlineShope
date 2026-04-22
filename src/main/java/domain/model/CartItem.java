package domain.model;

import java.io.Serializable;

public class CartItem implements Serializable {

    private final Long   productId;
    private final String description;
    private final double price;
    private final int    quantity;

    public CartItem(Long productId, String description, double price, int quantity) {
        if (productId   == null) throw new IllegalArgumentException("productId requis");
        if (description == null || description.isBlank()) throw new IllegalArgumentException("description requise");
        if (price < 0)           throw new IllegalArgumentException("prix invalide");
        if (quantity <= 0)       throw new IllegalArgumentException("quantite invalide");
        this.productId   = productId;
        this.description = description;
        this.price       = price;
        this.quantity    = quantity;
    }

    public CartItem withQuantity(int newQuantity) {
        return new CartItem(productId, description, price, newQuantity);
    }

    public Long   getProductId()   { return productId;        }
    public String getDescription() { return description;      }
    public double getPrice()       { return price;            }
    public int    getQuantity()    { return quantity;         }
    public double getSubtotal()    { return price * quantity; }

    @Override
    public String toString() {
        return description + " (x" + quantity + ") = " + getSubtotal() + "$";
    }
}