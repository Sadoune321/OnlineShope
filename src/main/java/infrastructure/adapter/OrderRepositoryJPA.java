package infrastructure.adapter;

import domain.model.CartItem;
import domain.model.Order;
import domain.port.IOrderRepository;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@Stateless
public class OrderRepositoryJPA implements IOrderRepository {

    @PersistenceContext(unitName = "MinishopPU")
    private EntityManager em;

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public Order save(Order order) {
        StringBuilder itemsText = new StringBuilder();
        for (CartItem item : order.getItems()) {
            itemsText.append(item.toString()).append(" | ");
        }

        try {
           
            em.createNativeQuery("INSERT INTO PURCHASE_ORDER(QUANTITY, SHIPPING_COST, SALES_DATE, FREIGHT_COMPANY) VALUES (?, ?, ?, ?)")
                .setParameter(1, order.getItemCount())
                .setParameter(2, order.getTotal())
                .setParameter(3, java.sql.Timestamp.valueOf(LocalDateTime.now()))
                .setParameter(4, "ORDER: " + itemsText)
                .executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Erreur sauvegarde commande: " + e.getMessage(), e);
        }
        return order;
    }

    @Override
    public List<Order> findAll() {
        return new ArrayList<>();
    }
}