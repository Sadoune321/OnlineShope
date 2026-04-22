package infrastructure.persistence;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;


@Entity
@Table(name = "PRODUCT")
public class ProductEntity {

    @Id
    @Column(name = "PRODUCT_ID")
    private Long id;

    @Column(name = "DESCRIPTION")
    private String description;

    @Column(name = "PURCHASE_COST")
    private double purchaseCost;

    @Column(name = "QUANTITY_ON_HAND")
    private int quantityOnHand;

    @Column(name = "AVAILABLE")
    private boolean available;

    @Column(name = "PRODUCT_CODE")
    private String productCode;

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