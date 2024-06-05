package val.shop.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import val.shop.connection.DbCon;
import val.shop.dao.*;
import val.shop.model.*;

@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String email = request.getParameter("login-email");
            String password = request.getParameter("login-password");

            UserDao udao = new UserDao(DbCon.getConnection());
            User user = udao.userLogin(email, password);
            if (user != null) {
                request.getSession().setAttribute("auth", user);
//				System.out.print("user logged in");
                if (user.getRole().equals("user")) {
                    response.sendRedirect("index.jsp");
                } else if (user.getRole().equals("admin")) {
                    response.sendRedirect("productsAdmin.jsp");
                }
            }
            else out.println("There is no user");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

    }
}
