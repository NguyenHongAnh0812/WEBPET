<%@page import="java.text.DecimalFormat"%>
<%@page import="val.shop.dao.OrderDao"%>
<%@page import="val.shop.connection.DbCon"%>
<%@page import="val.shop.dao.*"%>
<%@page import="val.shop.model.*"%>
<%@page import="java.util.*"%>
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
int ordersFont=600;
String color="black";
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/includes/head.jsp"%>
        <title>Shopping Cart</title>
    </head>
    <style>.btn {
            position: relative;
            z-index: 1;
        }

        .icon {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            opacity: 0;
            pointer-events: none;
        }

        .btn:hover .icon {
            opacity: 1;
        }
        .table-container {
            height: 400px;
            overflow:auto;
            border: 1px solid #ccc;
            text-align: center;
            margin-bottom: 20px;
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
            z-index: 20;
        }

        tbody {
            padding-top: 40px;

        }
    </style>
    <body style='background-color:#FFF6FA;'>
        <%@include file="/includes/navbar.jsp"%>
        <div style="margin-top: 150px;" class="container">
            <h2 class="card-header my-3">Orders</h2>
            <div class="table-container">
                <table class="table table-light" style='background-color:#FEE5E5;'>
                    <thead>
                        <tr style="text-align: center">
                            <th style="width: 10%" scope="col">Date</th>
                            <th style="width: 30%" scope="col">Name</th>
                            <th style="width: 10%" scope="col">Category</th>
                            <th style="width: 10%" scope="col">Quantity</th>
                            <th style="width: 10%" scope="col">Price</th>
                            <th style="width: 15%" scope="col">Status</th>
                            <th style="width: 10%" scope="col">Cancel</th>
                        </tr>
                    </thead>
                    <tbody>

                        <%
                        if(orders != null){
                                for(Order o:orders){%>
                        <tr style="text-align: center;height: 20%;">
                            <td><%=o.getDate() %></td>
                            <td><%=o.getName() %></td>
                            <td><%=o.getCategory() %></td>
                            <td><%=o.getO_qunatity() %></td>
                            <td  ><%=dcf.format(o.getPrice()) %></td>
                            <td style="font-weight: 800; color: red"><%=o.getStatus() %></td>
                            <% if(o.getStatus().equals("Chờ Phê Duyệt")){%>
                            <td><a class="btn btn-sm btn-success" href="cancel-order?id=<%=o.getOrderId()%>"disabled>Cancel Order</a></td>
                            <%}
else if(o.getStatus().equals("Đã Duyệt")) {%>
                            <td><a class="btn btn-sm btn-success" >
                                    <span class="button-text">Cancel Order</span>
                                    <span class="icon">&#x274C;</span>
                                </a></td>
                                <%}
else if(o.getStatus().equals("Từ Chối")) {%>
                    <td><a class="btn btn-sm btn-success" href="cancel-order?id=<%=o.getOrderId()%>"disabled>Remove</a></td>
                        <%}%>
                    </tr>
                    <%}
            }
                    %>

                    </tbody>
                </table>
            </div>
        </div>
        <%@include file="/includes/footer.jsp"%>
        <%@include file="/includes/html/foot.html"%>
    </body>
</html>