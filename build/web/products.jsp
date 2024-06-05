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
int itemsPerPage = 16; // Số sản phẩm trong mỗi trang
int totalPages = (int) Math.ceil((double) products.size() / itemsPerPage); // Tính tổng số trang

// Lấy tham số trang hiện tại từ request
int currentPage = 1;
String currentPageParam = request.getParameter("page");
if (currentPageParam != null) {
    currentPage = Integer.parseInt(currentPageParam);
    if (currentPage < 1) {
        currentPage = 1;
    } else if (currentPage > totalPages) {
        currentPage = totalPages;
    }
}

// Tính chỉ số sản phẩm bắt đầu và kết thúc của trang hiện tại
int startIndex = (currentPage - 1) * itemsPerPage;
int endIndex = Math.min(startIndex + itemsPerPage, products.size());

// Lấy danh sách sản phẩm cho trang hiện tại
List<Product> productsPerPage = products.subList(startIndex, endIndex);

// Lấy từ khóa tìm kiếm từ request
String searchQuery = request.getParameter("query");
if(searchQuery == null)searchQuery="";

// Kiểm tra nếu có từ khóa tìm kiếm
if (searchQuery != null && !searchQuery.isEmpty()) {
    // Tạo danh sách sản phẩm tìm kiếm
    List<Product> searchResults = new ArrayList<>();

    // Tìm kiếm sản phẩm theo từ khóa
    for (Product product : products) {
        if (product.getName().toLowerCase().contains(searchQuery.toLowerCase())) {
            searchResults.add(product);
        }
    }

    // Cập nhật danh sách sản phẩm và tính toán lại số trang
    productsPerPage = searchResults;
    totalPages = (int) Math.ceil((double) productsPerPage.size() / itemsPerPage);
}

%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/includes/head.jsp"%>
        <title>Shopping Cart</title>
        <style>
            .search-form {
                display: flex;
                align-items: center;
            }

            .search-input {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-right: 5px;
                font-size: 16px;
            }

            .search-button {
                padding: 8px 12px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
            }

            .search-button:hover {
                background-color: #45a049;
            }
            .card-title {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                height: 50px;
            }
        </style>
    </head>
    <body style='background-color:#FFF6FA;'>
        <%@include file="/includes/navbar.jsp"%>
        <div style="margin-top: 150px;" class="container">
            <div class="card-header my-3 text-center" style='background-color:#FFF6FA; display: flex; justify-content: space-between'>
                <h3>Products</h3>
                <form action="" method="GET" class="search-form">
                    <input type="text" placeholder="Search..." name="query" class="search-input" value="<%= searchQuery %>">
                    <button type="submit" class="search-button">Search</button>
                </form>
            </div>
            <div class="row">
                <% if (!productsPerPage.isEmpty()) {
                for (Product p : productsPerPage) { %>
                <div style="text-align: center;" class="col-md-3 my-3">
                    <div class="card w-100">
                        <a style="height: 250px;" href="productDetail?id=<%=p.getId()%>">
                            <img style="height: 250px;" height="250px" class="card-img-top" src="<%=p.getImage() %>" alt="Card image cap">
                        </a>
                        <div class="card-body" style='background-color:#FEE5E5;height: 200px'>
                            <h5 class="card-title"><%=p.getName() %></h5>
                            <h6 class="price">Price: $<%=p.getPrice() %></h6>
                            <h6 class="category">Category: <%=p.getCategory() %></h6>
                            <div class="mt-3 d-flex justify-content-between">
                                <a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>&p=p">Add to Cart</a>
                                <a class="btn btn-primary" href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>
                            </div>
                        </div>
                    </div>
                </div>
                <% }
                } else {
                    out.println("There are no products");
                } %>
            </div>

            <!-- Hiển thị phân trang -->
            <div style="display: flex; justify-content: flex-end">
                <div  class="row">
                    <div class="col-md-12 text-center mt-4">
                        <ul class="pagination">
                            <% for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) { %>
                            <li class="page-item active"><a class="page-link" href="?query=<%= searchQuery %>&page=<%=i%>"><%=i%></a></li>
                                <% } else { %>
                            <li class="page-item"><a class="page-link" href="?query=<%= searchQuery %>&page=<%=i%>"><%=i%></a></li>
                                <% }
                    } %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="/includes/footer.jsp"%>
        <%@include file="/includes/html/foot.html"%>
    </body>
</html>