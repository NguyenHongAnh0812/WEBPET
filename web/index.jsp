<%@page import="val.shop.connection.DbCon"%>
<%@page import="val.shop.dao.*"%>
<%@page import="val.shop.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
User auth = (User) request.getSession().getAttribute("auth");
List<Cart> cart_list = null;
List<Order> orders = null;
if (auth != null) {
    request.setAttribute("person", auth);
     OrderDao orderDao  = new OrderDao(DbCon.getConnection());
        orders = orderDao.userOrders(auth.getId());
        CartDao cartDao  = new CartDao(DbCon.getConnection());
        cart_list = cartDao.userCart(auth.getId());
}
ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();

%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>Shopping Cart</title>
</head>
<body style='background-color:#FFF6FA;'>
	<%@include file="/includes/navbar.jsp"%>
           <%@include file="/includes/carousel.jsp"%>

	<%@include file="/includes/footer.jsp"%>
           <%@include file="/includes/html/foot.html"%>
</body>
</html>