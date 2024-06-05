<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="val.shop.connection.DbCon"%>
<%@page import="val.shop.dao.*"%>
<%@page import="val.shop.model.*"%>
<%@page import="java.util.*"%>
<%
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
        <title>Add Product</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 4px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-top: 100px;
                margin-left: 400px;
            }
            .container1 {
                width: 100%;
                display: flex;
            }
            .box{
                width: 50%;
                padding: 10px;
            }
            h1 {
                text-align: center;
                margin-top: 0;
            }

            label {
                display: block;
                margin-bottom: 10px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="number"],
            input[type="file"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="submit"] {
                display: block;
                width: 120px;
                margin-top: 10px;
                padding: 10px;
                text-align: center;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }
            select {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            #preview {
                width: 300px;
                height: 260px;
                margin-top: 20px;
                border: 1px solid #ccc;
                padding: 10px;
                background-color: #f9f9f9;
                text-align: center;
            }

            #preview img {
                max-width: 100%;
                height: auto;
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
            h1 {
                text-align: center;
                margin-top: 20px;
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

            <h1>Add Product</h1>
            <div class="container1">

                <div class="box" id="preview"></div>
                <div class="box">
                    <form id="productForm" method="post" action="AddProductServlet">
                        <label for="image">Chọn ảnh:</label>
                        <input type="file" id="image" name="image" accept="image/*">

                        <label for="name">Tên sản phẩm:</label>
                        <input type="text" id="name" name="name" required>

                        <label for="type">Loại sản phẩm:</label>
                        <select id="type" name="type" required>
                            <option value="">Chọn loại</option>
                            <option value="Dog">Dog</option>
                            <option value="Cat">Cat</option>
                        </select>

                        <label for="price">Giá sản phẩm:</label>
                        <input type="number" id="price" name="price" required>



                        <input type="hidden" id="image1" name="image1">
                        <input type="submit" value="Thêm sản phẩm">
                    </form>
                </div>
            </div>


        </div>
        <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
        <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-storage.js"></script>
        <script>
            var ccc = document.getElementById('image1');
            var firebaseConfig = {
                apiKey: "AIzaSyAUwoXN8U-OZFuBXv824acHNSlxvX3tCfM",
                authDomain: "ce-web-8212b.firebaseapp.com",
                projectId: "ce-web-8212b",
                storageBucket: "ce-web-8212b.appspot.com",
                messagingSenderId: "121826669838",
                appId: "1:121826669838:web:4fe12f2dd18f1720c8d35f"
            };

            firebase.initializeApp(firebaseConfig);
            var storage = firebase.storage();

            function uploadFile() {
                var fileInput = document.querySelector('input[type="file"]');

                if (fileInput.files.length > 0) {
                    var currentDate = new Date().toISOString().slice(0, 10).replace(/-/g, '/');
                    var storageRef = storage.ref('uploads/' + currentDate + '/' + fileInput.files[0].name);

                    var uploadTask = storageRef.put(fileInput.files[0]);

                    return new Promise(function (resolve, reject) {
                        uploadTask.on('state_changed', function (snapshot) {
                            // Xử lý quá trình tải lên (nếu cần)
                        }, function (error) {
                            // Xử lý lỗi
                            console.error('Error uploading file: ', error);
                            reject(error);
                        }, function () {
                            // Xử lý khi tải lên thành công
                            console.log('File uploaded successfully!');

                            // Lấy URL của tệp đã tải lên
                            storageRef.getDownloadURL().then(function (url) {
                                // Trả về URL của tệp
                                resolve(url);
                            }).catch(function (error) {
                                console.error('Error getting download URL: ', error);
                                reject(error);
                            });
                        });
                    });
                } else {
                    return Promise.reject(new Error('Vui lòng chọn một tệp.'));
                }
            }

            document.getElementById('image').addEventListener('change', function (event) {
                var image = event.target.files[0];
                var reader = new FileReader();

                reader.onload = function (e) {
                    var previewImage = document.createElement('img');
                    previewImage.src = e.target.result;
                    previewImage.style.width = '100%'; // Đặt chiều rộng mặc định là 100%
                    previewImage.style.height = '100%'; // Đặt chiều cao mặc định là 100%

                    var previewContainer = document.getElementById('preview');
                    previewContainer.innerHTML = ''; // Xóa nội dung cũ
                    previewContainer.appendChild(previewImage);


                };
                uploadFile(image).then(function (url) {
                    // Hành động tiếp theo sau khi tệp đã tải lên thành công
                    ccc.value = url;
//                        alert(ccc.value);
                    if (image) {
                        reader.readAsDataURL(image);
                    }

                }).catch(function (error) {
                    // Xử lý lỗi nếu có
                    console.error('Error uploading file: ', error);
                });

            });

        </script>
    </body>
</html>