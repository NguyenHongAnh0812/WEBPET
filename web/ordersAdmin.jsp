<%@page import="java.text.DecimalFormat"%>
<%@page import="val.shop.dao.OrderDao"%>
<%@page import="val.shop.connection.DbCon"%>
<%@page import="val.shop.dao.*"%>
<%@page import="val.shop.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    List<Order> orders = null;
    List<Order> ddorders = null;
    List<Order> tcorders = null;
    OrderDao orderDao  = new OrderDao(DbCon.getConnection());
    orders = orderDao.cpdOrders();
    ddorders = orderDao.ddOrders();
    tcorders = orderDao.tcOrders();
User auth = (User) request.getSession().getAttribute("auth");
if(auth.getRole().equals("user"))
{
request.getSession().removeAttribute("auth");
response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Giao diện Đơn hàng</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            h1 {
                text-align: center;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                padding: 8px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
                position: sticky;
                top: 0;
                z-index: 1;
            }

            .table-title {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
                position: sticky;
                top: 0;
                background-color: #fff;
                z-index: 1;
            }

            .table-container {
                max-height: 250px;
                overflow-y: scroll;
            }

            #sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 200px;
                height: 100%;
                background-color: #333;
                color: #fff;
            }

            #sidebar ul {
                list-style: none;
                padding: 0;
                margin: 20px 0;
            }

            #sidebar ul li {
                margin-bottom: 5px;
            }

            #sidebar ul li a {
                display: block;
                padding: 10px;
                color: #fff;
                text-decoration: none;
            }
            .cancel-button {
                display: inline-block;
                padding: 0.5em 1em;
                font-size: 14px;
                font-weight: bold;
                text-align: center;
                text-decoration: none;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                color: #ffffff;
                background-color: #28a745;
                margin: 5px;
                width: 70px;
            }

            .cancel-button:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>

        <div id="sidebar">
            <h1>Hi, Admin</h1>
            <ul>
                <li><a href="productsAdmin.jsp">Quản lý sản phẩm</a></li>
                <li><a href="ordersAdmin.jsp">Đơn hàng</a></li>
                <li><a href="stat.jsp">Thống kê</a></li>
                <li><a href="log-out">Đăng xuất</a></li>
            </ul>
        </div>

        <div class="container" style="margin-left: 280px;">
            <h1>Quản Lý Đơn Hàng</h1> 
            <h2 class="ta">Đơn hàng mới</h2>
            <div class="table-container">
                <table id="don-hang-moi">
                    <thead>
                        <tr style="text-align: center">
                            <th style="width:15%"  scope="col">Tên Khách Hàng</th>
                            <th style="width:10%"  scope="col">SĐT</th>
                            <th style="width:10%"  scope="col">Địa Chỉ</th>
                            <th  scope="col">Tên Sản Phẩm</th>
                            <th  style="width:10%"  scope="col">Số Lượng</th>
                            <th style="width:10%"   scope="col">Tổng Tiền</th>
                            <th  scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        if(orders != null){
                                for(Order o:orders){%>
                        <tr style="text-align: center;height: 20%;">
                            <td><%=o.getFull_name()%></td>
                            <td><%=o.getNumber_phone()%></td>
                            <td><%=o.getAddress()%></td>
                            <td><%=o.getName()%></td>
                            <td  ><%=dcf.format(o.getO_qunatity()) %></td>
                            <td >$<%=o.getPrice()%></td>
                            <td>
                                <a class="btn btn-sm btn-success cancel-button" href="AcceptServlet?id=<%=o.getOrderId()%>&action=d">Duyệt</a>
                                <a class="btn btn-sm btn-success cancel-button" href="AcceptServlet?id=<%=o.getOrderId()%>&action=tc">Từ chối</a>
                            </td>   
                        </tr>
                        <%}
                }
                        %>
                        <!-- More rows... -->
                    </tbody>
                </table>
            </div>
            <h2>Đơn hàng đã duyệt</h2>
            <div class="table-container">
                <table id="don-hang-da-duyet">
                    <thead>
                        <tr style="text-align: center">
                            <th style="width:15%"  scope="col">Tên Khách Hàng</th>
                            <th style="width:10%"  scope="col">SĐT</th>
                            <th style="width:10%"  scope="col">Địa Chỉ</th>
                            <th  scope="col">Tên Sản Phẩm</th>
                            <th    scope="col">Số Lượng</th>
                            <th    scope="col">Tổng Tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        if(ddorders != null){
                                for(Order o:ddorders){%>
                        <tr style="text-align: center;height: 20%;">
                            <td><%=o.getFull_name()%></td>
                            <td><%=o.getNumber_phone()%></td>
                            <td><%=o.getAddress()%></td>
                            <td><%=o.getName()%></td>
                            <td  ><%=dcf.format(o.getO_qunatity()) %></td>
                            <td >$<%=o.getPrice()%></td>

                        </tr>
                        <%}
                }
                        %>
                        <!-- More rows... -->
                    </tbody>
                </table>
            </div>
            <h2>Đơn hàng đã từ chối</h2>
            <div class="table-container">
                <table id="don-hang-da-tu-choi">
                    <thead>
                        <tr style="text-align: center">
                            <th style="width:15%"  scope="col">Tên Khách Hàng</th>
                            <th style="width:10%"  scope="col">SĐT</th>
                            <th style="width:10%"  scope="col">Địa Chỉ</th>
                            <th  scope="col">Tên Sản Phẩm</th>
                            <th  style="width:10%"  scope="col">Số Lượng</th>
                            <th style="width:10%"   scope="col">Tổng Tiền</th>
                            <th  scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        if(tcorders != null){
                                for(Order o:tcorders){%>
                        <tr style="text-align: center;height: 20%;">
                            <td><%=o.getFull_name()%></td>
                            <td><%=o.getNumber_phone()%></td>
                            <td><%=o.getAddress()%></td>
                            <td><%=o.getName()%></td>
                            <td  ><%=dcf.format(o.getO_qunatity()) %></td>
                            <td >$<%=o.getPrice()%></td>
                            <td><a class="btn btn-sm btn-success cancel-button" href="cancel-order?id=<%=o.getOrderId()%>">Remove</a></td>  
                        </tr>
                        <%}
                }
                        %>
                        <!-- More rows... -->
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>