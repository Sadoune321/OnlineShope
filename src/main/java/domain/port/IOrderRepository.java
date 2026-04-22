package domain.port;

import domain.model.Order;
import java.util.List;


public interface IOrderRepository {
    Order save(Order order);
    List<Order> findAll();
}