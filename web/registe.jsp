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

}
	
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/includes/head.jsp"%>
        <title>Registration</title>
    </head>
    <style>
        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
    <body style='background-color:#FFF6FA;'>
        <%@include file="/includes/navbar.jsp"%>

        <div style="margin-top: 150px;" class="container">
            <div class="card w-50 mx-auto my-5">
                <div class="card-header text-center bg-danger text-white">User Registration</div>
                <div class="card-body" style='background-color:#FFDCDC;'>
                    <form action="RegisteServlet" method="post">
                        <div class="form-group">
                            <label>Email</label> 
                            <input type="email" name="registration-email" class="form-control" placeholder="Enter email" style='background-color:#FFF6FA;'>
                            <h4 class="error-message">${requestScope.error}</h4>
                        </div>
                        <div class="form-group">
                            <label>Password</label> 
                            <input type="password" name="registration-password" class="form-control" placeholder="Enter password" style='background-color:#FFF6FA;'>
                        </div>
                        <div class="form-group">
                            <label>Full Name</label> 
                            <input type="text" name="registration-fullname" class="form-control" placeholder="Enter full name" style='background-color:#FFF6FA;'>
                        </div>
                        <div class="form-group">
                            <label>Number Phone</label> 
                            <input type="text" name="registration-numberphone" class="form-control" placeholder="Enter number phone" style='background-color:#FFF6FA;'>
                            <h4 class="error-message">${requestScope.error1}</h4>
                        </div>
                        <div class="form-group">
                            <label>Date</label> 
                            <input type="date" name="registration-date" class="form-control"  style='background-color:#FFF6FA;'>
                        </div>
                        <div class="form-group">
                            <label>Address</label> 
                            <input type="text" name="registration-address" class="form-control" placeholder="Enter address"  style='background-color:#FFF6FA;'>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-danger">Register</button>
                        </div>
                    </form>
                    <a href="login.jsp" >Already Have Account ?</a>
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