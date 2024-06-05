<%@page import="val.shop.model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="val.shop.dao.OrderDao"%>
<%@page import="val.shop.connection.DbCon"%>
<%@page import="val.shop.dao.*"%>
<%@page import="val.shop.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    int cartCout=0,ordersCout=0;	
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
}else{
request.getSession().removeAttribute("auth");
        response.sendRedirect("login.jsp");
}
if(cart_list==null)cartCout=0;
else cartCout=cart_list.size();
if(orders==null)ordersCout=0;
else ordersCout=orders.size();

%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/includes/head.jsp"%>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <title>Shopping Cart</title>
    </head>
    <body style='background-color:#FFF6FA;'>
        <%@include file="/includes/navbar.jsp"%>
        <section style="background-color: #FFF6FA;">

            <div class="container py-5" style="margin-top: 100px">

                <%--<%@include file="/includes/navbar.jsp"%>--%>
                <div class="row">
                    <div class="col-lg-4">
                        <div class="card mb-4">
                            <div class="card-body text-center">
                                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp" alt="avatar"
                                     class="rounded-circle img-fluid" style="width: 150px;">
                                <h5 class="my-3"><%=auth.getFullname()%></h5>
                                <p class="text-muted mb-1"><%=auth.getDate()%></p>
                                <p class="text-muted mb-4"><%=auth.getAddress()%></p>
                                <div class="d-flex justify-content-center mb-2">
                                    <button type="button" class="btn btn-primary">Follow</button>
                                    <button type="button" class="btn btn-outline-primary ms-1">Message</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="card mb-4">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Full Name</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%=auth.getFullname()%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Email</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%=auth.getEmail()%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Number Phone</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%=auth.getNumberphone()%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Date</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%=auth.getDate()%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Address</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%=auth.getAddress()%></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card mb-4 mb-md-0">
                                    <div style="display: flex; justify-content: center; align-items: center;flex-direction: column" class="card-body">
                                        <p style="font-size: 30px; font-weight: 600" class="mb-4">Cart</p>
                                        <h2><%=cartCout%></h2>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card mb-4 mb-md-0">
                                    <div class="card mb-4 mb-md-0">
                                        <div style="display: flex; justify-content: center; align-items: center;flex-direction: column" class="card-body">
                                            <p style="font-size: 30px; font-weight: 600" class="mb-4">Order</p>
                                            <h2><%=ordersCout%></h2>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <%@include file="/includes/footer.jsp"%>
        <%@include file="/includes/html/foot.html"%>
    </body>
</html>


