<%@page import="val.shop.model.*"%>
<%@page import="val.shop.connection.DbCon"%>
<%@page import="val.shop.dao.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
User auth = (User) request.getSession().getAttribute("auth");
List<Cart> cart_list = null;
List<Order> orders = null;
int cartCout=0,ordersCout=0;
if(cart_list==null)cartCout=0;
else cartCout=cart_list.size();
if(orders==null)ordersCout=0;
else ordersCout=orders.size();
if (auth != null) {
response.sendRedirect("index.jsp");

}
	
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/includes/head.jsp"%>
        <title>Shopping Cart</title>
    </head>
    <body style='background-color:#FFF6FA;'>
        <%@include file="/includes/navbar.jsp"%>

        <div style="margin-top: 150px;" class="container">
            <div class="card w-50 mx-auto my-5">
                <div class="card-header text-center bg-danger text-white">Login</div>
                <div class="card-body" style='background-color:#FFDCDC;'>
                    <form action="user-login" method="post">
                        <div class="form-group">
                            <label>Email </label> 
                            <input type="email" name="login-email" class="form-control" placeholder="Enter email" style='background-color:#FFF6FA;'>
                        </div>
                        <div class="form-group">
                            <label>Password</label> 
                            <input type="password" name="login-password" class="form-control" placeholder="Enter password" style='background-color:#FFF6FA;'>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-danger">Login</button>
                        </div>
                    </form>
                    <a href="registe.jsp" >Creat Accout ?</a>
                </div>
            </div>
        </div>
        <br>
        <br>
        <br>
        <%@include file="/includes/footer.jsp"%>
        <%@include file="/includes/html/foot.html"%>
    </body>
</html>