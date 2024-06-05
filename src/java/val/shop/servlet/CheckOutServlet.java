package val.shop.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

import val.shop.connection.DbCon;
import val.shop.dao.CartDao;
import val.shop.dao.OrderDao;
import val.shop.model.*;

@WebServlet("/cart-check-out")
public class CheckOutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            String fullname = request.getParameter("fullname");
            String address = request.getParameter("address");
            String numberphone = request.getParameter("numberphone");
            String status="Chờ Phê Duyệt";
            CartDao cartDao = new CartDao(DbCon.getConnection());
                
            User auth = (User) request.getSession().getAttribute("auth");
            List<Cart> cart_list = cartDao.userCart(auth.getId());
            if (cart_list != null && auth != null) {
                for (Cart c : cart_list) {
                    Order order = new Order();
                    order.setId(c.getId());
                    order.setUid(auth.getId());
                    order.setO_qunatity(c.getC_quantity());
                    order.setDate(formatter.format(date));
                    order.setFull_name(fullname);
                    order.setAddress(address);
                    order.setNumber_phone(numberphone);
                    order.setStatus(status);
                    OrderDao oDao = new OrderDao(DbCon.getConnection());
                    boolean result = oDao.insertOrder(order);
                    cartDao.cancelCart(c.getId());
                    if (!result) {
                        break;
                    }
                }
                cart_list.clear();
                response.sendRedirect("orders.jsp");
            } else {
                if (auth == null) {
                    response.sendRedirect("login.jsp");
                } else if (cart_list == null) {
                    response.sendRedirect("cart.jsp");
                }
//				response.sendRedirect("cart.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {

            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
//        try ( PrintWriter out = response.getWriter()) {
//            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//            Date date = new Date();
//            String fullname = request.getParameter("fullname");
//            String address = request.getParameter("address");
//            String numberphone = request.getParameter("numberphone");
//            ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
//            User auth = (User) request.getSession().getAttribute("auth");
//            if (cart_list != null && auth != null) {
//                for (Cart c : cart_list) {
//                    Order order = new Order();
//                    order.setId(c.getId());
//                    order.setUid(auth.getId());
//                    order.setQunatity(c.getQuantity());
//                    order.setDate(formatter.format(date));
//                    order.setFull_name(fullname);
//                    order.setAddress(address);
//                    order.setNumber_phone(numberphone);
//                    OrderDao oDao = new OrderDao(DbCon.getConnection());
//                    boolean result = oDao.insertOrder(order);
//                    if (!result) {
//                        break;
//                    }
//                }
//                cart_list.clear();
//                response.sendRedirect("orders.jsp");
//            } else {
//                if (auth == null) {
//                    response.sendRedirect("login.jsp");
//                } else if (cart_list == null) {
//                    response.sendRedirect("cart.jsp");
//                }
////				response.sendRedirect("cart.jsp");
//            }
//        } catch (ClassNotFoundException | SQLException e) {
//
//            e.printStackTrace();
//        }
    }

}
