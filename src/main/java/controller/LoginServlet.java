package controller;

import dao.AdminDAO;
import dao.UserDAO;
import model.Admin;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        try {
            if ("admin".equals(userType)) {
                AdminDAO adminDAO = new AdminDAO();
                Admin admin = adminDAO.authenticate(username, password);

                if (admin != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("admin", admin);
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    request.setAttribute("errorMessage", "Invalid admin credentials");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                UserDAO userDAO = new UserDAO();
                User user = userDAO.authenticate(username, password);

                if (user != null) {
                    // Update login time
                    userDAO.updateLoginTime(user.getUserId());

                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    response.sendRedirect("userDashboard.jsp");
                } else {
                    request.setAttribute("errorMessage", "Invalid user credentials");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}