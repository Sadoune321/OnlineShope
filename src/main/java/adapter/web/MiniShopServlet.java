package adapter.web;

import domain.model.CartItem;
import domain.model.Order;
import domain.model.Product;
import domain.port.IShopUseCase;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "MiniShopServlet", urlPatterns = {"/shop"})
public class MiniShopServlet extends HttpServlet {

    
    @EJB(beanName = "ShopService")
    private IShopUseCase shopUseCase;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        handleRequest(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        handleRequest(req, res);
    }

    private void handleRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "view";

        switch (action) {
            case "add":
                handleAdd(req, res);
                break;
            case "checkout":
                handleCheckout(req, res);
                break;
            case "reset":
                shopUseCase.resetCart();
                req.setAttribute("message", "Panier vide.");
                forwardToView(req, res);
                break;
            default:
                forwardToView(req, res);
                break;
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String param = req.getParameter("product");
        if (param == null || param.trim().isEmpty()) {
            req.setAttribute("error", "Veuillez sélectionner un produit.");
        } else {
            try {
                CartItem added = shopUseCase.addToCart(Long.parseLong(param));
                req.setAttribute("message",
                        "'" + added.getDescription() + "' ajouté au panier.");
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Identifiant de produit invalide.");
            } catch (Exception e) {
                req.setAttribute("error", e.getMessage());
            }
        }
        forwardToView(req, res);
    }

    private void handleCheckout(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            Order order = shopUseCase.checkout();
            req.setAttribute("confirmedOrder", order);
            req.setAttribute("message",
                    "Commande confirmée ! " + order.getItemCount() +
                    " article(s) — Total : " +
                    String.format("%.2f", order.getTotal()) + "$");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }
        forwardToView(req, res);
    }

    private void forwardToView(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("allProducts", shopUseCase.getAvailableProducts());
        req.setAttribute("cartItems",   shopUseCase.getCartItems());
        req.setAttribute("cartTotal",   shopUseCase.getCartTotal());
        req.setAttribute("itemCount",   shopUseCase.getCartItemCount());
        req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, res);
    }
}