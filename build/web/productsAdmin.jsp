<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="val.shop.connection.DbCon"%>
<%@page import="val.shop.dao.*"%>
<%@page import="val.shop.model.*"%>
<%@page import="java.util.*"%>
<%

List<Cart> cart_list = null;
List<Order> orders = null;
List<Product> products = null;      
ProductDao pd = new ProductDao(DbCon.getConnection());
products = pd.getAllProducts();
int itemsPerPage = 10; // Số lượng sản phẩm hiển thị trên mỗi trang
int currentPage = 1; // Trang hiện tại, bạn có thể thay đổi giá trị này để hiển thị trang khác

if (request.getParameter("page") != null) {
    currentPage = Integer.parseInt(request.getParameter("page"));
}

int totalProducts = products.size();
int totalPages = (int) Math.ceil((double) totalProducts / itemsPerPage);

int startIndex = (currentPage - 1) * itemsPerPage;
int endIndex = Math.min(startIndex + itemsPerPage, totalProducts);

List<Product> productsOnPage = products.subList(startIndex, endIndex);
User auth = (User) request.getSession().getAttribute("auth");
if(auth.getRole().equals("user") && auth !=null)
{
request.getSession().removeAttribute("auth");
response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý Sản phẩm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                margin-left: 250px;
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
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #f5f5f5;
            }

            .add-button {
                display: block;
                width: 120px;
                margin: 20px auto;
                padding: 10px;
                text-align: center;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 4px;
            }

            .add-button:hover {
                background-color: #45a049;
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
            .pagination {
                text-align: right;
                margin-top: 20px;
            }

            .pagination a {
                display: inline-block;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid #ddd;
                margin-left: 4px;
            }

            .pagination a:hover {
                background-color: #ddd;
            }

            .pagination .active {
                background-color: #4CAF50;
                color: white;
            }
            .button {
                display: inline-block;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                background-color: #007bff;
                color: #fff;
                border-radius: 4px;
                border: none;
                cursor: pointer;
            }

            .button:hover {
                background-color: #0056b3;
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
            <h1>Quản lý Sản phẩm</h1>
            <a href="addProduct.jsp" class="add-button">Thêm sản phẩm</a>
            <table>
                <thead>
                    <tr>
                        <th>Ảnh</th>
                        <th>Tên</th>
                        <th>Loại</th>
                        <th>Giá</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if(productsOnPage != null){
                                for(Product p:productsOnPage){%>
                    <tr>

                        <td><img src="<%=p.getImage() %>" alt="Product Image" width="50" height="50"></td>
                        <td><%=p.getName() %></td>
                        <td><%=p.getCategory() %></td>
                        <td>$<%=p.getPrice() %></td>
                        <td>
                            <a href="EditProductServlet?id=<%=p.getId()%>" class="button">Edit</a>
                            <a href="DeleteProductServlet?id=<%=p.getId()%>" class="button">Delete</a>
                        </td>

                    </tr>
                    <%}}%>
                    <!-- Add more rows as needed -->
                </tbody>
            </table>
            <div class="pagination">
                <% if (currentPage > 1) { %>
                <a href="?page=<%= currentPage - 1 %>">&laquo; Previous</a>
                <% } %>

                <% for (int i = 1; i <= totalPages; i++) { %>
                <a href="?page=<%= i %>"><%= i %></a>
                <% } %>

                <% if (currentPage < totalPages) { %>
                <a href="?page=<%= currentPage + 1 %>">Next &raquo;</a>
                <% } %>
            </div>
        </div>
    </body>
</html>