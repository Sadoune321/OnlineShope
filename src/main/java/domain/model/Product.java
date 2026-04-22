package domain.model;

import java.io.Serializable;

public class Product implements Serializable {

    private Long    id;
    private String  description;
    private double  purchaseCost;
    private int     quantityOnHand;
    private boolean available;
    private String  productCode;

    public Product() {}

    public Product(Long id, String description, double purchaseCost,
                   int quantityOnHand, boolean available, String productCode) {
        this.id             = id;
        this.description    = description;
        this.purchaseCost   = purchaseCost;
        this.quantityOnHand = quantityOnHand;
        this.available      = available;
        this.productCode    = productCode;
    }

    // Règle métier pure — pas de dépendance externe
    public boolean isOrderable() {
        return available && quantityOnHand > 0;
    }

    public double getPriceWithDiscount(double discountPercent) {
        return purchaseCost * (1.0 - discountPercent / 100.0);
    }

    public Long    getId()             { return id;             }
    public String  getDescription()    { return description;    }
    public double  getPurchaseCost()   { return purchaseCost;   }
    public int     getQuantityOnHand() { return quantityOnHand; }
    public boolean isAvailable()       { return available;      }
    public String  getProductCode()    { return productCode;    }

    public void setId(Long id)              { this.id = id;             }
    public void setDescription(String d)    { this.description = d;     }
    public void setPurchaseCost(double c)   { this.purchaseCost = c;    }
    public void setQuantityOnHand(int q)    { this.quantityOnHand = q;  }
    public void setAvailable(boolean a)     { this.available = a;       }
    public void setProductCode(String c)    { this.productCode = c;     }
}