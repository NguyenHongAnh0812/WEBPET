package val.shop.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import val.shop.connection.DbCon;
import val.shop.dao.CartDao;

import val.shop.model.Cart;
import val.shop.model.User;

@WebServlet("/remove-from-cart")
public class RemoveFromCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            User auth = (User) request.getSession().getAttribute("auth");

            if (auth != null) {
                String bookId = request.getParameter("id");
                if (bookId != null) {
                    CartDao cartDao = new CartDao(DbCon.getConnection());
                    List<Cart> cart_list = cartDao.userCart(auth.getId());
                    if (cart_list != null) {
                        for (Cart c : cart_list) {
                            if (c.getId() == Integer.parseInt(bookId)) {
                                cartDao.cancelCart(Integer.parseInt(bookId));
                                break;
                            }
                        }
                    }
                    response.sendRedirect("cart.jsp");

                } else {
                    response.sendRedirect("cart.jsp");
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

}
