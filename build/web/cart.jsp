<%@page import="val.shop.connection.DbCon"%>
<%@page import="val.shop.dao.ProductDao"%>
<%@page import="val.shop.dao.*"%>
<%@page import="val.shop.model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
pageEncoding="ISO-8859-1"%>
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
List<Cart> cart_list = null;
List<Order> orders = null;
if (auth != null && auth.getRole().equals("user")) {
    request.setAttribute("person", auth);
     OrderDao orderDao  = new OrderDao(DbCon.getConnection());
        orders = orderDao.userOrders(auth.getId());
        CartDao cartDao  = new CartDao(DbCon.getConnection());
        cart_list = cartDao.userCart(auth.getId());
}
else{
request.getSession().removeAttribute("auth");
        response.sendRedirect("login.jsp");
}
List<Cart> cartProduct = null;
if (cart_list != null) {
    ProductDao pDao = new ProductDao(DbCon.getConnection());
    cartProduct = pDao.getCartProducts(cart_list);
    double total = pDao.getTotalCartPrice(cart_list);
    request.setAttribute("total", total);
    request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/includes/head.jsp"%>
        <title>Shopping Cart</title>
        <style type="text/css">
            .table-container {
                height: 300px;
                overflow:auto;
                border: 1px solid #ccc;
                text-align: center;
            }

            .table {
                width: 100%;
                /*border-collapse: collapse;*/
                border: 1px solid #ccc;
            }

            thead {
                position: sticky;
                top: -1px;
                background-color: #f9f9f9;
                border: 1px solid #ccc;
            }

            tbody {
                padding-top: 40px;

            }

            .table thead th {
                background-color: #f9f9f9;
                border: 1px solid #ccc;
                /*padding: 8px;*/
                text-align: left;
            }

            .table tbody td {
                border: 1px solid #ccc;
                padding: 8px;
            }

            .form-inline {
                display: flex;
                width: 100%;
                justify-content: center;
                align-items: center;
                margin: 10px 10px;
            }


            .buy-now-column {
                width: 20%;
            }

            .buy-now-column .form-group {
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .buy-now-column .btn {
                margin: 0 2px;
                font-size: 1.5rem;
            }

            .buy-now-column input[type="text"] {
                width: 60%;
                text-align: center;
            }

            .table tbody tr:hover {
                background-color: #e5e5e5;
            }

            /* Custom styling for the total price section */
            .total-price {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-top: 10px;
            }

            .total-price h3 {
                margin-bottom: 0;
                font-weight: bold;
            }
        </style>
    </head>
    <body style='background-color:#FFF6FA;'>
        <%@include file="/includes/navbar.jsp"%>

        <div style="margin-top: 150px;" class="container">

            <div class="row">

                <div class="col-md-8">

                    <h3>Order Information</h3>
                    <div class="table-container">
                        <table class="table table-light" style='background-color:#FEE5E5;'>
                            <thead>
                                <tr style="text-align: center">
                                    <th style="width:35%" scope="col">Name</th>
                                    <th style="width:15%" scope="col">Category</th>
                                    <th style="width:10%" scope="col">Price</th>
                                    <th style="width:25%" scope="col">Quantity</th>
                                    <th style="width:15%" scope="col">Cancel</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (cart_list != null && cart_list.size() > 0) {
                                  for (Cart c : cartProduct) {
                                %>
                                <tr style="text-align: center">
                                    <td style="width:25%"><%=c.getName()%></td>
                                    <td style="width:15%"><%=c.getCategory()%></td>
                                    <td><%= dcf.format(c.getPrice())%></td>
                                    <td style="width:25%" class="buy-now-column">
                                        <div class="form-group d-flex flex-row">
                                            <a class="btn bnt-sm btn-incre" href="quantity-inc-dec?action=inc&id=<%=c.getId()%>"><i class="fas fa-plus-square"></i></a>
                                            <input type="text" name="quantity" class="form-control" value="<%=c.getC_quantity()%>" readonly>
                                            <a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=<%=c.getId()%>"><i class="fas fa-minus-square"></i></a>
                                        </div>
                                    </td>
                                    <td><a href="remove-from-cart?id=<%=c.getId() %>" class="btn btn-sm btn-danger">Remove</a></td>
                                </tr>
                                <% } } %>
                            </tbody>
                        </table>
                        <% if (cartProduct == null || cartProduct.isEmpty()) { %>
                        <h3 style="margin-top:105px">No Product</h3>
                        <% } %>
                    </div>
                    <div class="d-flex py-3">
                        <h3>Total Price: $ ${(total>0)?dcf.format(total):0}

                        </h3>
                    </div>
                </div>
                <div class="col-md-4">
                    <h3>Buyer Information</h3>
                    <form action="cart-check-out" method="get">
                        <div class="form-group">
                            <label for="fullname">Full Name:</label>
                            <input type="text" name="fullname" id="fullname"  class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="address">Address:</label>
                            <input type="text" name="address" id="address"  class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="numberphone">Number Phone:</label>
                            <input type="text" name="numberphone" id="numberphone"  class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-success">Check Out</button>
                    </form>
                </div>
            </div>
        </div>

        <%@include file="/includes/footer.jsp"%>
        <%@include file="/includes/html/foot.html"%>
    </body>
</html>