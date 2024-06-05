<%@page import="val.shop.model.*"%>
<%@page import="val.shop.connection.DbCon"%>
<%@page import="val.shop.dao.*"%>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
int cartCout=0,ordersCout=0;
if(cart_list==null)cartCout=0;
else cartCout=cart_list.size();
if(orders==null)ordersCout=0;
else ordersCout=orders.size();
if (auth != null) {
//response.sendRedirect("index.jsp");

}
	
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Product Detail</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
        <%@include file="/includes/head.jsp"%>
    </head>
    <style>

        body {
            overflow-x: hidden;
        }

        img {
            max-width: 100%;
            height: 410px;
        }

        .preview {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: vertical;
            -webkit-box-direction: normal;
            -webkit-flex-direction: column;
            -ms-flex-direction: column;
            flex-direction: column;
        }
        @media screen and (max-width: 996px) {
            .preview {
                margin-bottom: 20px;
            }
        }

        .preview-pic {
            -webkit-box-flex: 1;
            -webkit-flex-grow: 1;
            -ms-flex-positive: 1;
            flex-grow: 1;
        }

        .preview-thumbnail.nav-tabs {
            border: none;
            margin-top: 15px;
        }
        .preview-thumbnail.nav-tabs li {
            width: 18%;
            margin-right: 2.5%;
        }
        .preview-thumbnail.nav-tabs li img {
            max-width: 100%;
            display: block;
        }
        .preview-thumbnail.nav-tabs li a {
            padding: 0;
            margin: 0;
        }
        .preview-thumbnail.nav-tabs li:last-of-type {
            margin-right: 0;
        }

        .tab-content {
            overflow: hidden;
        }
        .tab-content img {
            width: 100%;
            -webkit-animation-name: opacity;
            animation-name: opacity;
            -webkit-animation-duration: .3s;
            animation-duration: .3s;
        }

        .card {
            margin-top: 50px;
            background: #fff;
            padding: 3em;
            /*line-height: 1.5em;*/
            display: flex;
            align-items: center;
            justify-content: center;
        }

        @media screen and (min-width: 997px) {
            .wrapper {
                display: -webkit-box;
                display: -webkit-flex;
                display: -ms-flexbox;
                display: flex;
            }
        }

        .details {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: vertical;
            -webkit-box-direction: normal;
            -webkit-flex-direction: column;
            -ms-flex-direction: column;
            flex-direction: column;
        }

        .colors {
            -webkit-box-flex: 1;
            -webkit-flex-grow: 1;
            -ms-flex-positive: 1;
            flex-grow: 1;
        }

        .product-title, .price, .sizes, .colors {
            text-transform: UPPERCASE;
            font-weight: bold;
        }

        .checked, .price span {
            color: #ff9f1a;
        }

        .product-title, .rating, .product-description, .price, .vote, .sizes {
            margin-bottom: 15px;
        }

        .product-title {
            margin-top: 0;
        }

        .size {
            margin-right: 10px;
        }
        .size:first-of-type {
            margin-left: 40px;
        }

        .color {
            display: inline-block;
            vertical-align: middle;
            margin-right: 10px;
            height: 2em;
            width: 2em;
            border-radius: 2px;
        }
        .color:first-of-type {
            margin-left: 20px;
        }

        .add-to-cart, .like {
            background: #ff9f1a;
            padding: 1.2em 1.5em;
            border: none;
            text-transform: UPPERCASE;
            font-weight: bold;
            color: #fff;
            -webkit-transition: background .3s ease;
            transition: background .3s ease;
        }
        .add-to-cart:hover, .like:hover {
            background: #b36800;
            color: #fff;
        }

        .not-available {
            text-align: center;
            line-height: 2em;
        }
        .not-available:before {
            font-family: fontawesome;
            content: "\f00d";
            color: #fff;
        }

        .orange {
            background: #ff9f1a;
        }

        .green {
            background: #85ad00;
        }

        .blue {
            background: #0076ad;
        }

        .tooltip-inner {
            padding: 1.3em;
        }

        @-webkit-keyframes opacity {
            0% {
                opacity: 0;
                -webkit-transform: scale(3);
                transform: scale(3);
            }
            100% {
                opacity: 1;
                -webkit-transform: scale(1);
                transform: scale(1);
            }
        }

        @keyframes opacity {
            0% {
                opacity: 0;
                -webkit-transform: scale(3);
                transform: scale(3);
            }
            100% {
                opacity: 1;
                -webkit-transform: scale(1);
                transform: scale(1);
            }
        }
    </style>
    <body style='background-color:#FFF6FA;'>
        <%@include file="/includes/navbar.jsp"%>

        <c:set var="c" value="${requestScope.data}" />
        <div style="margin-top:100px" class="container">
            <div class="card">
                <div class="container-fliud">
                    <div class="wrapper row">
                        <div class="preview col-md-6">
                            <div class="preview-pic tab-content">
                                <div class="tab-pane active" id="pic-1"><img src="${c.getImage()}" /></div>
                                <div class="tab-pane" id="pic-2"><img src="${c.getImage()}" /></div>
                                <div class="tab-pane" id="pic-3"><img src="${c.getImage()}" /></div>
                                <div class="tab-pane" id="pic-4"><img src="${c.getImage()}" /></div>
                                <div class="tab-pane" id="pic-5"><img src="${c.getImage()}" /></div>
                            </div>
                        </div>
                        <div class="details col-md-6">
                            <h1 class="product-title">${c.getName()}</h1>

                            <p style="font-size:15px" class="product-description">Sản phẩm thú cưng đóng vai trò quan trọng trong việc chăm sóc và nuôi dưỡng thú cưng của chúng ta. Có rất nhiều loại sản phẩm được thiết kế đặc biệt để đáp ứng nhu cầu và yêu cầu của từng loại thú cưng.</p>
                            
                            <h2 class="price">category: <span>${c.getCategory()}</span></h2>
                            <h2 class="price">current price: <span>${c.getPrice()}</span> $</h2>

                            <div style=" margin-top: 40px" class="action">
                                <a style="font-size:30px; margin-right: 60px" class="btn btn-dark" href="add-to-cart?id=${c.getId()}&p=pd">Add to Cart</a>
                                <a style="font-size:30px" class="btn btn-primary" href="order-now?quantity=1&id=${c.getId()}">Buy Now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <br>
    <br>
    <br>
    <%@include file="/includes/footer.jsp"%>
    <%@include file="/includes/html/foot.html"%>
</html>