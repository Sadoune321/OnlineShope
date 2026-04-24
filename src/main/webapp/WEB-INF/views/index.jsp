<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"    prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"     prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MiniShop — Boutique</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --cream:       #faf6f0;
            --cream-dark:  #f0e9de;
            --cream-deep:  #e8ddd0;
            --warm-white:  #fffdf9;
            --gold:        #c9a84c;
            --gold-light:  #e8c97a;
            --gold-dark:   #9a7530;
            --brown:       #5c3d2e;
            --brown-light: #8b6552;
            --text:        #2c1a0e;
            --text-2:      #7a5c48;
            --text-3:      #b8a090;
            --green:       #4a7c59;
            --red:         #9b3a3a;
            --shadow-sm:   0 2px 8px rgba(92,61,46,0.08);
            --shadow-md:   0 8px 32px rgba(92,61,46,0.12);
            --shadow-lg:   0 20px 60px rgba(92,61,46,0.16);
            --shadow-3d:   0 4px 0 rgba(150,110,80,0.25), 0 8px 24px rgba(92,61,46,0.15);
            --radius:      20px;
            --radius-sm:   12px;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--cream);
            color: var(--text);
            min-height: 100vh;
            -webkit-font-smoothing: antialiased;
        }

        /* Texture de fond */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image:
                radial-gradient(circle at 20% 20%, rgba(201,168,76,0.08) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(92,61,46,0.06) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
        }

        /* ── HEADER ── */
        header {
            position: sticky;
            top: 0;
            z-index: 100;
            background: rgba(250,246,240,0.88);
            backdrop-filter: blur(20px) saturate(150%);
            -webkit-backdrop-filter: blur(20px) saturate(150%);
            border-bottom: 1px solid rgba(201,168,76,0.2);
            padding: 0 40px;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .logo-mark {
            width: 38px;
            height: 38px;
            background: linear-gradient(145deg, var(--gold-light), var(--gold-dark));
            border-radius: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            box-shadow: var(--shadow-3d);
            transform: perspective(100px) rotateX(5deg);
            transition: transform 0.3s ease;
        }

        .logo-mark:hover { transform: perspective(100px) rotateX(0deg) scale(1.05); }

        .logo-name {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.6rem;
            font-weight: 600;
            color: var(--brown);
            letter-spacing: 0.5px;
        }

        .logo-name span { color: var(--gold-dark); }

        .cart-btn {
            display: flex;
            align-items: center;
            gap: 9px;
            background: linear-gradient(145deg, var(--brown), var(--brown-light));
            color: var(--cream);
            border: none;
            border-radius: 50px;
            padding: 9px 18px 9px 14px;
            font-size: 0.85rem;
            font-weight: 500;
            font-family: inherit;
            cursor: default;
            box-shadow: var(--shadow-3d);
            transform: perspective(200px) rotateX(3deg);
            transition: transform 0.2s;
        }

        .cart-badge {
            background: var(--gold);
            color: var(--brown);
            border-radius: 50%;
            width: 22px;
            height: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.78rem;
            font-weight: 700;
        }

        /* ── LAYOUT ── */
        .container {
            position: relative;
            z-index: 1;
            max-width: 1100px;
            margin: 32px auto;
            padding: 0 24px;
            display: grid;
            grid-template-columns: 1fr 360px;
            gap: 24px;
            align-items: start;
        }

        /* ── CARDS 3D ── */
        .card {
            background: var(--warm-white);
            border-radius: var(--radius);
            border: 1px solid rgba(201,168,76,0.18);
            box-shadow: var(--shadow-3d);
            padding: 28px;
            transform: perspective(1000px) rotateX(1deg);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: perspective(1000px) rotateX(0deg) translateY(-2px);
            box-shadow: 0 6px 0 rgba(150,110,80,0.20), 0 16px 40px rgba(92,61,46,0.14);
        }

        .card + .card { margin-top: 20px; }

        .card-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--brown);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 9px;
            letter-spacing: 0.2px;
            padding-bottom: 14px;
            border-bottom: 1px solid var(--cream-deep);
        }

        /* ── ALERTS ── */
        .alert {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 13px 16px;
            border-radius: var(--radius-sm);
            margin-bottom: 18px;
            font-size: 0.87rem;
            font-weight: 500;
            animation: slideIn 0.35s cubic-bezier(0.34,1.2,0.64,1);
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-10px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .alert-success {
            background: rgba(74,124,89,0.10);
            color: #2d5c3a;
            border: 1px solid rgba(74,124,89,0.22);
            border-left: 3px solid var(--green);
        }

        .alert-error {
            background: rgba(155,58,58,0.09);
            color: #7a2020;
            border: 1px solid rgba(155,58,58,0.20);
            border-left: 3px solid var(--red);
        }

        /* ── ORDER CONFIRMED ── */
        .order-confirmed {
            background: linear-gradient(135deg, rgba(201,168,76,0.12), rgba(201,168,76,0.05));
            border: 1px solid rgba(201,168,76,0.30);
            border-radius: var(--radius-sm);
            padding: 18px 20px;
            margin-bottom: 20px;
            animation: slideIn 0.4s ease;
        }

        .order-confirmed h3 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.05rem;
            font-weight: 600;
            color: var(--gold-dark);
            margin-bottom: 5px;
        }

        .order-confirmed p {
            font-size: 0.85rem;
            color: var(--brown-light);
        }

        /* ── SELECT ── */
        .form-label {
            display: block;
            font-size: 0.78rem;
            font-weight: 600;
            color: var(--text-2);
            margin-bottom: 8px;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        select {
            width: 100%;
            padding: 13px 40px 13px 16px;
            border: 1.5px solid var(--cream-deep);
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
            font-family: inherit;
            color: var(--text);
            background: var(--cream);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%239a7530' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            cursor: pointer;
            transition: border-color 0.2s, box-shadow 0.2s;
            box-shadow: inset 0 2px 4px rgba(92,61,46,0.05);
        }

        select:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(201,168,76,0.18), inset 0 2px 4px rgba(92,61,46,0.05);
        }

        /* ── BUTTONS ── */
        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
            font-weight: 600;
            font-family: inherit;
            cursor: pointer;
            letter-spacing: 0.3px;
            transition: all 0.2s cubic-bezier(0.34, 1.2, 0.64, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn:active { transform: scale(0.97) translateY(2px); }

        .btn-primary {
            background: linear-gradient(145deg, var(--brown), var(--brown-light));
            color: var(--cream);
            margin-top: 14px;
            box-shadow: 0 4px 0 var(--gold-dark), 0 6px 20px rgba(92,61,46,0.25);
        }

        .btn-primary:hover {
            box-shadow: 0 6px 0 var(--gold-dark), 0 10px 28px rgba(92,61,46,0.30);
            transform: translateY(-2px);
        }

        .btn-gold {
            background: linear-gradient(145deg, var(--gold-light), var(--gold));
            color: var(--brown);
            margin-top: 12px;
            box-shadow: 0 4px 0 var(--gold-dark), 0 6px 20px rgba(201,168,76,0.30);
            font-weight: 700;
        }

        .btn-gold:hover {
            box-shadow: 0 6px 0 var(--gold-dark), 0 10px 28px rgba(201,168,76,0.40);
            transform: translateY(-2px);
        }

        .btn-outline {
            background: transparent;
            color: var(--red);
            border: 1.5px solid rgba(155,58,58,0.22);
            margin-top: 10px;
        }

        .btn-outline:hover {
            background: rgba(155,58,58,0.07);
            border-color: var(--red);
        }

        /* ── TABLE ── */
        table { width: 100%; border-collapse: collapse; }

        thead th {
            font-size: 0.68rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.9px;
            color: var(--text-3);
            padding: 0 12px 12px;
            text-align: left;
            border-bottom: 1px solid var(--cream-deep);
        }

        tbody tr { transition: background 0.15s; }
        tbody tr:hover td { background: var(--cream); }

        td {
            padding: 13px 12px;
            font-size: 0.88rem;
            border-bottom: 1px solid rgba(92,61,46,0.05);
        }

        tbody tr:last-child td { border-bottom: none; }

        .td-id {
            color: var(--text-3);
            font-size: 0.75rem;
            font-weight: 600;
            width: 32px;
        }

        .td-name { font-weight: 500; color: var(--text); }

        .td-price {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1rem;
            font-weight: 700;
            color: var(--brown);
            white-space: nowrap;
        }

        .stock-pill {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            border-radius: 50px;
            padding: 4px 11px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .stock-ok  { background: rgba(74,124,89,0.10);  color: var(--green); }
        .stock-low { background: rgba(201,168,76,0.15); color: var(--gold-dark); }

        /* ── PANIER ── */
        .cart-empty {
            text-align: center;
            padding: 36px 0;
            color: var(--text-3);
        }

        .cart-empty-icon { font-size: 2.8rem; display: block; margin-bottom: 10px; }

        .cart-empty-text {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.1rem;
            color: var(--text-3);
        }

        .cart-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid rgba(92,61,46,0.06);
        }

        .cart-item:last-of-type { border-bottom: none; }

        .cart-item-icon {
            width: 36px;
            height: 36px;
            background: var(--cream-dark);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            flex-shrink: 0;
            box-shadow: inset 0 2px 4px rgba(92,61,46,0.08);
        }

        .cart-item-name {
            flex: 1;
            font-size: 0.87rem;
            font-weight: 500;
            color: var(--text);
        }

        .cart-item-qty {
            background: var(--cream-dark);
            color: var(--brown-light);
            border-radius: 50px;
            padding: 3px 10px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .cart-item-price {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1rem;
            font-weight: 700;
            color: var(--brown);
            min-width: 72px;
            text-align: right;
        }

        .cart-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0 4px;
            margin-top: 10px;
            border-top: 1px solid var(--cream-deep);
        }

        .cart-total-label {
            font-size: 0.82rem;
            font-weight: 600;
            color: var(--text-2);
            text-transform: uppercase;
            letter-spacing: 0.6px;
        }

        .cart-total-value {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--brown);
            letter-spacing: -0.5px;
        }

        @media (max-width: 768px) {
            .container { grid-template-columns: 1fr; }
            header { padding: 0 20px; }
        }
    </style>
</head>
<body>

<!-- HEADER -->
<header>
    <a href="${pageContext.request.contextPath}/" class="logo">
        <div class="logo-mark">🛍</div>
        <span class="logo-name">Mini<span>Shop</span></span>
    </a>
    <div class="cart-btn">
        <span>🛒</span>
        <span>Panier</span>
        <span class="cart-badge">${itemCount}</span>
    </div>
</header>

<!-- CONTAINER -->
<div class="container">

    <!-- COLONNE GAUCHE -->
    <div>

        <c:if test="${not empty message}">
            <div class="alert alert-success">✓&nbsp; ${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">✕&nbsp; ${error}</div>
        </c:if>

        <c:if test="${not empty confirmedOrder}">
            <div class="order-confirmed">
                <h3>✨ Commande confirmée</h3>
                <p>${confirmedOrder.itemCount} article(s) · Total : <fmt:formatNumber value="${confirmedOrder.total}" pattern="#,##0.00"/>$</p>
            </div>
        </c:if>

        <!-- Formulaire -->
        <div class="card">
            <div class="card-title">📦 Choisir un produit</div>
            <form action="${pageContext.request.contextPath}/shop" method="POST">
                <input type="hidden" name="action" value="add"/>
                <label class="form-label" for="product">Produit disponible</label>
                <select name="product" id="product">
                    <option value="">— Sélectionnez un produit —</option>
                    <c:forEach var="p" items="${allProducts}">
                        <option value="${p.id}">
                            ${p.description} · <fmt:formatNumber value="${p.purchaseCost}" pattern="#,##0.00"/>$
                        </option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn btn-primary">＋ Ajouter au panier</button>
            </form>
        </div>

        <!-- Catalogue -->
        <div class="card">
            <div class="card-title">📋 Catalogue</div>
            <c:choose>
                <c:when test="${empty allProducts}">
                    <p style="text-align:center;color:var(--text-3);padding:24px 0;">Aucun produit disponible.</p>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Description</th>
                                <th>Prix</th>
                                <th>Stock</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${allProducts}">
                                <tr>
                                    <td class="td-id">${p.id}</td>
                                    <td class="td-name">${p.description}</td>
                                    <td class="td-price"><fmt:formatNumber value="${p.purchaseCost}" pattern="#,##0.00"/>$</td>
                                    <td>
                                        <span class="stock-pill ${p.quantityOnHand <= 5 ? 'stock-low' : 'stock-ok'}">
                                            ${p.quantityOnHand}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- COLONNE DROITE : Panier -->
    <div>
        <div class="card">
            <div class="card-title">🛒 Mon Panier</div>

            <c:choose>
                <c:when test="${empty cartItems}">
                    <div class="cart-empty">
                        <span class="cart-empty-icon">🧺</span>
                        <span class="cart-empty-text">Votre panier est vide</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item">
                            <div class="cart-item-icon">🎁</div>
                            <span class="cart-item-name">${item.description}</span>
                            <span class="cart-item-qty">×${item.quantity}</span>
                            <span class="cart-item-price"><fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/>$</span>
                        </div>
                    </c:forEach>

                    <div class="cart-total">
                        <span class="cart-total-label">Total</span>
                        <span class="cart-total-value"><fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/>$</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/shop" method="POST">
                        <input type="hidden" name="action" value="checkout"/>
                        <button type="submit" class="btn btn-gold">✓ Valider la commande</button>
                    </form>

                    <form action="${pageContext.request.contextPath}/shop" method="POST">
                        <input type="hidden" name="action" value="reset"/>
                        <button type="submit" class="btn btn-outline">Vider le panier</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>
</body>
</html>
