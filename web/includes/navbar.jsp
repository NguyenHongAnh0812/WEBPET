<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav style="background-color: #fff; border-bottom: 1px solid #d5d5d5; position: fixed; top: 0; left: 0; width: 100%; z-index: 9999; margin-bottom: 200px" class="navbar navbar-expand-lg navbar-light">
    <div class="container">
        <img style="height: 100px; width: 200px" src="product-image/logo.jpeg" alt="Arrifvdfvdfval">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a style="font-size: 20px;" class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a style="font-size: 20px;" class="nav-link" href="products.jsp">Products</a></li>
                <li class="nav-item"><a style="font-size: 20px;" class="nav-link" href="cart.jsp">Cart 
                        <span class="badge badge-danger">
                            <% if (cart_list !=null) { %>
                            <%=cart_list.size()%>
                            <%} else {%>
                            0
                            <%}%>
                        </span></a></li>
                        <% if (auth != null) { %>
                <li class="nav-item"><a style="font-size: 20px; " class="nav-link" href="orders.jsp">Orders 
                        <span class="badge badge-danger">
                            <% if (orders !=null) { %>
                            <%=orders.size()%>
                            <%} else {%>
                            0
                            <%}%>
                        </span></a></li>
                <li style="margin-left:20px"  class="nav-item">
                    <a style="font-size: 20px;" class="nav-link" id="user-info-icon"><i class="fas fa-user"></i></a>
                    
                    <div class="user-info">
                        <a class="user-info-row" href="infor.jsp">Accout Infor</a>
                        <a class="user-info-row" href="log-out">Logout</a>
                    </div>
                </li>
                <% } else { %>
                <li class="nav-item"><a style="font-size: 20px;" class="nav-link" href="login.jsp">Login</a></li>
                    <% } %>
            </ul>
        </div>
    </div>
</nav>

<style>
    .user-info {
        display: none;
        position: absolute;
        height: 100px;
        width: 150px;
        top: 80px;
        right: 100px;
        background-color: #f9f9f9;
        /*padding: 10px;*/
        border: 1px solid #ccc;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        
        
    }
    #logout{
        position: relative;
    }

    .user-info-row {
        height: 50%;
        width: 100%;
        border: 1px solid #ccc; 
        color: black !important;
        font-weight: 600;
        text-decoration: none !important;
         display: flex;
        justify-content: center;
        align-items: center;
        font-size: 15px;
    }
    .user-info-row:hover {
        color: red !important;
        background-color: #fff;
    }
    .nav-item:hover .user-info {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        text-align: center;
    }
</style>