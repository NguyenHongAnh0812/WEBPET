<%@page import="java.text.DecimalFormat"%>
<%@page import="val.shop.dao.OrderDao"%>
<%@page import="val.shop.connection.DbCon"%>
<%@page import="val.shop.dao.*"%>
<%@page import="val.shop.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    OrderDao orderDao  = new OrderDao(DbCon.getConnection());
    double top=0,top2=0;
    int topq=0,topq2=0;
    String month="",month2="";
    
    double t1=orderDao.monthOrders(1);
    int t1q=orderDao.monthQualityOrders(1);
    if(t1>top){
        top=t1;
        topq=t1q;
        month="1";
    }
    if(t1>top2 && t1<top){
        top2=t1;
        topq2=t1q;
        month2="1";
    }
    
    double t2=orderDao.monthOrders(2);
    int t2q=orderDao.monthQualityOrders(2);
    if(t2>top){
        top=t2;
        topq=t2q;
        month="2";
    }
    if(t2>top2 && t2<top){
        top2=t2;
        topq2=t2q;
        month2="2";
    }
    
    double t3=orderDao.monthOrders(3);
    int t3q=orderDao.monthQualityOrders(3);
    if(t3>top){
        top=t3;
        topq=t3q;
        month="3";
    }
    if(t3>top2 && t3<top){
        top2=t3;
        topq2=t3q;
        month2="3";
    }
    
    double t4=orderDao.monthOrders(4);
    int t4q=orderDao.monthQualityOrders(4);
    if(t4>top){
        top=t4;
        topq=t4q;
        month="4";
    }
    if(t4>top2 && t4<top){
        top2=t4;
        topq2=t4q;
        month2="4";
    }
    
    double t5=orderDao.monthOrders(5);
    int t5q=orderDao.monthQualityOrders(5);
    if(t5>top){
        top=t5;
        topq=t5q;
        month="5";
    }
    if(t5>top2 && t5<top){
        top2=t5;
        topq2=t5q;
        month2="5";
    }
    
    double t6=orderDao.monthOrders(6);
    int t6q=orderDao.monthQualityOrders(6);
    if(t6>top){
        top=t6;
        topq=t6q;
        month="6";
    }
    if(t6>top2 && t6<top){
        top2=t6;
        topq2=t6q;
        month2="6";
    }
    
    double t7=orderDao.monthOrders(7);
    int t7q=orderDao.monthQualityOrders(7);
    if(t7>top){
        top=t7;
        topq=t7q;
        month="7";
    }
    if(t7>top2 && t7<top){
        top2=t7;
        topq2=t7q;
        month2="7";
    }
    
    double t8=orderDao.monthOrders(8);
    int t8q=orderDao.monthQualityOrders(8);
    if(t8>top){
        top=t8;
        topq=t8q;
        month="8";
    }
    if(t8>top2 && t8<top){
        top2=t8;
        topq2=t8q;
        month2="8";
    }
    
    double t9=orderDao.monthOrders(9);
    int t9q=orderDao.monthQualityOrders(9);
    if(t9>top){
        top=t9;
        topq=t9q;
        month="9";
    }
    if(t9>top2 && t9<top){
        top2=t9;
        topq2=t9q;
        month2="9";
    }
    
    double t10=orderDao.monthOrders(10);
    int t10q=orderDao.monthQualityOrders(10);
    if(t10>top){
        top=t10;
        topq=t10q;
        month="10";
    }
    if(t10>top2 && t10<top){
        top2=t10;
        topq2=t10q;
        month2="0";
    }
    
    double t11=orderDao.monthOrders(11);
    int t11q=orderDao.monthQualityOrders(11);
    if(t11>top){
        top=t11;
        topq=t11q;
        month="11";
    }
    if(t11>top2 && t11<top){
        top2=t11;
        topq2=t11q;
        month2="11";
    }
    
    double t12=orderDao.monthOrders(12);
    int t12q=orderDao.monthQualityOrders(12);
    if(t12>top){
        top=t12;
        topq=t12q;
        month="12";
    }
    if(t12>top2 && t12<top){
        top2=t12;
        topq2=t12q;
        month2="12";
    }
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
        <title>Thống kê đơn hàng theo tháng</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                /*padding: 20px;*/
                margin-left: 400px;
            }

            h1 {
                text-align: center;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 8px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #f5f5f5;
            }

            canvas {
                margin-top: 20px;
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
        <div class="container">
            <h1>Thống kê đơn hàng theo tháng</h1>
            <h2>Top 2 tháng có doanh thu cao nhất</h2>
            <table>
                <thead>
                    <tr>
                        <th>Tháng</th>
                        <th>Số lượng đơn hàng</th>
                        <th>Tổng doanh thu</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Tháng <%=month%></td>
                        <td><%=topq%></td>
                        <td>$<%=top%></td>
                    </tr>
                    <tr>
                        <td>Tháng <%=month2%></td>
                        <td><%=topq2%></td>
                        <td>$<%=top2%></td>
                    </tr>
                    <!-- Add other data rows here -->
                </tbody>
            </table>
            <canvas id="chart"></canvas>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            var ctx = document.getElementById('chart').getContext('2d');
            var chart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'], // Add month names
                    datasets: [
                        
                        {
                            label: 'Số lượng đơn hàng',
                            data: [<%=t1q%>, <%=t2q%>, <%=t3q%>, <%=t4q%>, <%=t5q%>, <%=t6q%>, <%=t7q%>, <%=t8q%>, <%=t9q%>, <%=t10q%>, <%=t11q%>, <%=t12q%>], // Add total revenue data for each month
                            backgroundColor: 'rgba(54, 162, 235, 0.5)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1,
                            yAxisID: 'revenue-axis' // Assign a unique ID to the dataset
                        },{
                            label: 'Tổng doanh thu',
                            data: [<%=t1%>, <%=t2%>, <%=t3%>, <%=t4%>, <%=t5%>, <%=t6%>, <%=t7%>, <%=t8%>, <%=t9%>, <%=t10%>, <%=t11%>, <%=t12%>], // Add order quantity data for each month
                            backgroundColor: 'rgba(255, 99, 132, 0.5)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1,
                            yAxisID: 'quantity-axis' // Assign a unique ID to the dataset
                        }
                    ]
                },
                options: {
                    scales: {
                        quantity: {
                            type: 'linear',
                            position: 'left',
                            beginAtZero: true,
                            scaleLabel: {
                                display: true,
                                labelString: 'Số lượng đơn hàng'
                            },
                            id: 'revenue-axis', // Assign a unique ID to the quantity axis
                            ticks: {
                                callback: function (value) {
                                    if (Number.isInteger(value) && value > 1) {
                                        return value;
                                    }
                                    return '';
                                }
                            }
                        },
                        revenue: {
                            type: 'linear',
                            position: 'right',
                            beginAtZero: true,
                            scaleLabel: {
                                display: true,
                                labelString: 'Tổng doanh thu'
                            },
                            id: 'quantity-axis', // Assign a unique ID to the revenue axis
                            ticks: {
                                callback: function (value) {
                                    if (Number.isInteger(value) && value > 1) {
                                        return value;
                                    }
                                    return '';
                                }
                            }
                        }
                    }
                }
            });
        </script>
    </body>
</html>