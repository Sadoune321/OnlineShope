<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"    prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"     prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MiniShop — Architecture Hexagonale</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f2f5;
            color: #333;
        }
        header {
            background: linear-gradient(135deg, #1a237e, #283593);
            color: white;
            padding: 18px 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header h1 { font-size: 1.5rem; }
        .badge {
            background: #ff6f00;
            color: white;
            border-radius: 50%;
            padding: 2px 8px;
            font-size: 0.8rem;
            margin-left: 6px;
        }
        .arch-banner {
            background: #e8eaf6;
            border-left: 4px solid #3949ab;
            padding: 10px 32px;
            font-size: 0.85rem;
            color: #3949ab;
        }
        .container {
            max-width: 1100px;
            margin: 24px auto;
            padding: 0 16px;
            display: grid;
            grid-template-columns: 1fr 380px;
            gap: 24px;
        }
        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 24px;
        }
        .card h2 {
            font-size: 1.1rem;
            color: #1a237e;
            margin-bottom: 16px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e8eaf6;
        }
        /* Notifications */
        .alert {
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 16px;
            font-size: 0.9rem;
        }
        .alert-success { background: #e8f5e9; color: #2e7d32; border-left: 3px solid #4caf50; }
        .alert-error   { background: #ffebee; color: #c62828; border-left: 3px solid #f44336; }
        /* Formulaire */
        .form-group { margin-bottom: 14px; }
        .form-group label { display: block; font-size: 0.85rem; color: #666; margin-bottom: 5px; }
        select, input[type="text"] {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 0.95rem;
        }
        select:focus { outline: none; border-color: #3949ab; }
        /* Boutons */
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
            transition: opacity 0.2s;
        }
        .btn:hover { opacity: 0.88; }
        .btn-primary  { background: #1a237e; color: white; width: 100%; margin-top: 4px; }
        .btn-success  { background: #2e7d32; color: white; width: 100%; margin-top: 10px; }
        .btn-danger   { background: #c62828; color: white; width: 100%; margin-top: 8px; }
        /* Table produits */
        table { width: 100%; border-collapse: collapse; }
        th { background: #e8eaf6; color: #3949ab; font-size: 0.82rem;
             text-transform: uppercase; padding: 10px 12px; text-align: left; }
        td { padding: 10px 12px; font-size: 0.9rem; border-bottom: 1px solid #f0f2f5; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #fafafa; }
        .price { font-weight: 700; color: #1a237e; }
        .qty   { color: #666; font-size: 0.85rem; }
        /* Panier */
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #f0f2f5;
            font-size: 0.9rem;
        }
        .cart-item:last-child { border-bottom: none; }
        .cart-item-name  { flex: 1; }
        .cart-item-qty   { color: #888; margin: 0 12px; font-size: 0.82rem; }
        .cart-item-price { font-weight: 700; color: #1a237e; }
        .cart-total {
            display: flex;
            justify-content: space-between;
            font-weight: 700;
            font-size: 1.05rem;
            padding: 14px 0 0;
            margin-top: 10px;
            border-top: 2px solid #1a237e;
            color: #1a237e;
        }
        .empty-cart { text-align: center; color: #aaa; padding: 20px 0; font-size: 0.9rem; }
        /* Confirmed order */
        .order-confirmed {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            border-radius: 8px;
            padding: 16px;
            margin-top: 16px;
        }
        .order-confirmed h3 { color: #2e7d32; margin-bottom: 8px; }
    </style>
</head>
<body>

<header>
    <h1>🏪 MiniShop</h1>
    <div>
        Panier
        <span class="badge">${itemCount}</span>
    </div>
</header>

<div class="arch-banner">
    ✦ Architecture Hexagonale (Ports &amp; Adapters) — Servlet [Adaptateur Web] → IShopUseCase [Port] → ShopService [Domaine] → IProductRepository / ICartRepository [Ports] → JPA + MySQL Docker [Adaptateurs Infrastructure]
</div>

<div class="container">

    <%-- COLONNE GAUCHE : Catalogue + Formulaire --%>
    <div>

        <%-- Notifications --%>
        <c:if test="${not empty message}">
            <div class="alert alert-success">✔ ${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">✖ ${error}</div>
        </c:if>

        <%-- Commande confirmée --%>
        <c:if test="${not empty confirmedOrder}">
            <div class="order-confirmed">
                <h3>✅ Commande confirmée</h3>
                <p>${confirmedOrder.itemCount} article(s) — Total : <fmt:formatNumber value="${confirmedOrder.total}" pattern="#,##0.00"/>$</p>
            </div>
        </c:if>

        <%-- Formulaire ajout --%>
        <div class="card">
            <h2>📦 Choisir un produit</h2>
            <form action="${pageContext.request.contextPath}/shop" method="POST">
                <input type="hidden" name="action" value="add"/>
                <div class="form-group">
                    <label for="product">Produit disponible :</label>
                    <select name="product" id="product">
                        <option value="">-- Sélectionnez un produit --</option>
                        <c:forEach var="p" items="${allProducts}">
                            <option value="${p.id}">
                                ${p.description} — <fmt:formatNumber value="${p.purchaseCost}" pattern="#,##0.00"/>$ (stock: ${p.quantityOnHand})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">➕ Ajouter au panier</button>
            </form>
        </div>

        <%-- Catalogue --%>
        <div class="card" style="margin-top:20px;">
            <h2>📋 Catalogue complet</h2>
            <c:choose>
                <c:when test="${empty allProducts}">
                    <p class="empty-cart">Aucun produit disponible.</p>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Description</th>
                                <th>Prix</th>
                                <th>Stock</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${allProducts}">
                                <tr>
                                    <td>${p.id}</td>
                                    <td>${p.description}</td>
                                    <td class="price"><fmt:formatNumber value="${p.purchaseCost}" pattern="#,##0.00"/>$</td>
                                    <td class="qty">${p.quantityOnHand} unité(s)</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- COLONNE DROITE : Panier --%>
    <div>
        <div class="card">
            <h2>🛒 Mon Panier</h2>

            <c:choose>
                <c:when test="${empty cartItems}">
                    <p class="empty-cart">Votre panier est vide.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item">
                            <span class="cart-item-name">${item.description}</span>
                            <span class="cart-item-qty">x${item.quantity}</span>
                            <span class="cart-item-price">
                                <fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/>$                             </span>
                        </div>
                    </c:forEach>

                    <div class="cart-total">
                        <span>Total</span>
                        <span><fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/>$</span>
                    </div>

                    <%-- Checkout --%>
                    <form action="${pageContext.request.contextPath}/shop" method="POST">
                        <input type="hidden" name="action" value="checkout"/>
                        <button type="submit" class="btn btn-success">✅ Valider la commande</button>
                    </form>

                    <%-- Reset --%>
                    <form action="${pageContext.request.contextPath}/shop" method="POST">
                        <input type="hidden" name="action" value="reset"/>
                        <button type="submit" class="btn btn-danger">🗑 Vider le panier</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Schéma architecture --%>
        <div class="card" style="margin-top:20px; font-size:0.78rem; color:#555; line-height:1.7;">
            <h2>🏗 Architecture</h2>
            <code style="display:block; background:#f5f5f5; padding:12px; border-radius:6px; font-size:0.75rem;">
                [Browser]<br>
                &nbsp;&nbsp;↓ HTTP<br>
                [MiniShopServlet]<br>
                &nbsp;&nbsp;↓ IShopUseCase (Port Primaire)<br>
                [ShopService ← Domaine Pur]<br>
                &nbsp;&nbsp;↓ IProductRepository (Port)<br>
                &nbsp;&nbsp;↓ ICartRepository (Port)<br>
                [ProductRepositoryJPA]<br>
                [CartRepositoryEJB @Stateful]<br>
                &nbsp;&nbsp;↓ JPA / EntityManager<br>
                [MySQL Docker :3307]
            </code>
        </div>
    </div>

</div>
</body>
</html>