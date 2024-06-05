/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package val.shop.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import val.shop.connection.DbCon;
import val.shop.dao.CartDao;
import val.shop.dao.UserDao;
import val.shop.model.Cart;
import val.shop.model.User;

/**
 *
 * @author nguyenhonganh
 */
@WebServlet(name = "RegisteServlet", urlPatterns = {"/RegisteServlet"})
public class RegisteServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisteServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisteServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            Date dateFormat = new Date();
            UserDao userDao = new UserDao(DbCon.getConnection());
            String email = request.getParameter("registration-email");
            String password = request.getParameter("registration-password");
            String fullname = request.getParameter("registration-fullname");
            String numberphone = request.getParameter("registration-numberphone");
            LocalDate birthdate = LocalDate.parse(request.getParameter("registration-date"));
            String address = request.getParameter("registration-address");
            String role = "user";
            
            String date = birthdate.format(formatter);
            boolean check = userDao.checkEmail(email);
            boolean check1 = userDao.checkNumber(numberphone);
            if(check ==true && check1==true)
            {
            User user = new User();
            user.setEmail(email);
            user.setPassword(password);
            user.setFullname(fullname);
            user.setNumberphone(numberphone);
            user.setDate(date);
            user.setAddress(address);
            user.setRole(role);
            userDao.insertUser(user);
            response.sendRedirect("login.jsp");
            }
            else {
                if(check==false)request.setAttribute("error", "Email đã tồn tại");
                else if(check1==false)request.setAttribute("error1", "Number Phone đã tồn tại");
                request.getRequestDispatcher("registe.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
