package controller;

import dao.ItemDAO;
import model.Item;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/")
public class ItemController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ItemDAO itemDAO;

    public void init() {
        try {
            itemDAO = new ItemDAO();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        // Handle empty path (root context)
        if (action == null || action.equals("") || action.equals("/")) {
            action = "/list";
        }

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/insert":
                    insertItem(request, response);
                    break;
                case "/delete":
                    deleteItem(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateItem(request, response);
                    break;
                case "/list":
                    listItems(request, response);
                    break;
                default:
                    // Redirect to list if unknown path
                    response.sendRedirect("list");
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Item> listItems = itemDAO.getAllItems();
        request.setAttribute("listItems", listItems);
        RequestDispatcher dispatcher = request.getRequestDispatcher("item-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        RequestDispatcher dispatcher = request.getRequestDispatcher("add-item.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Item existingItem = itemDAO.getItemById(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("edit-item.jsp");
        request.setAttribute("item", existingItem);
        dispatcher.forward(request, response);
    }

    private void insertItem(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));

        Item newItem = new Item(0, name, category, quantity, price);
        itemDAO.addItem(newItem);
        response.sendRedirect("list");
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));

        Item item = new Item(id, name, category, quantity, price);
        itemDAO.updateItem(item);
        response.sendRedirect("list");
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        itemDAO.deleteItem(id);
        response.sendRedirect("list");
    }
}