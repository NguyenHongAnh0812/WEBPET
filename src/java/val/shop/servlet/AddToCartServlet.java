package val.shop.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import val.shop.connection.DbCon;
import val.shop.dao.CartDao;
import val.shop.dao.OrderDao;

import val.shop.model.*;

@WebServlet(name = "AddToCartServlet", urlPatterns = "/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();

            User auth = (User) request.getSession().getAttribute("auth");

            if (auth != null) {
                String productId = request.getParameter("id");
                String p = request.getParameter("p");
                int id = Integer.parseInt(request.getParameter("id"));
                int productQuantity = 1;
                CartDao cartDao = new CartDao(DbCon.getConnection());
                List<Cart> cart_list = cartDao.userCart(auth.getId());
                boolean cartUpdated = false;

                for (Cart c : cart_list) {
                    if (c.getId() == id) {
                        int k = c.getC_quantity();
                        k++;
                        cartDao.updateCart(id, k);
                        cartUpdated = true;
                        break;
                    }
                }

                if (!cartUpdated) {
                    Cart cartModel = new Cart();
                    cartModel.setPid(Integer.parseInt(productId));
                    cartModel.setUid(auth.getId());
                    cartModel.setC_quantity(productQuantity);
                    cartModel.setDate(formatter.format(date));
                    cartDao.insertCart(cartModel);
                }
                if(p.equals("p"))
                response.sendRedirect("products.jsp");
                else
                response.sendRedirect("cart.jsp");
            } else {
                response.sendRedirect("login.jsp");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

//        try ( PrintWriter out = response.getWriter()) {
////        	out.print("add to cart servlet");
//
//            ArrayList<Cart> cartList = new ArrayList<>();
//            int id = Integer.parseInt(request.getParameter("id"));
//            Cart cm = new Cart();
//            cm.setId(id);
//            cm.setC_quantity(1);
//            HttpSession session = request.getSession();
//            ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
//            if (cart_list == null) {
//                cartList.add(cm);
//                session.setAttribute("cart-list", cartList);
//                response.sendRedirect("products.jsp");
//            } else {
//                cartList = cart_list;
//
//                boolean exist = false;
//                for (Cart c : cart_list) {
//                    if (c.getId() == id) {
//                        exist = true;
//                        int k = c.getC_quantity();
//                        k++;
//                        c.setC_quantity(k);
//                        response.sendRedirect("products.jsp");
//                    }
//                }
//
//                if (!exist) {
//                    cartList.add(cm);
//                    response.sendRedirect("products.jsp");
//                }
//            }
//        }
    }

}
