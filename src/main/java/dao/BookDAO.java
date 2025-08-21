package dao;

import model.Book;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/shop";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String INSERT_BOOK_SQL = "INSERT INTO books (title, author, price, stock_quantity) VALUES (?, ?, ?, ?)";
    private static final String SELECT_BOOK_BY_ID = "SELECT * FROM books WHERE book_id=?";
    private static final String SELECT_ALL_BOOKS = "SELECT * FROM books";
    private static final String DELETE_BOOK_SQL = "DELETE FROM books WHERE book_id=?";
    private static final String UPDATE_BOOK_SQL = "UPDATE books SET title=?, author=?, price=?, stock_quantity=? WHERE book_id=?";

    public BookDAO() {}

    protected Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertBook(Book book) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_BOOK_SQL)) {
            preparedStatement.setString(1, book.getTitle());
            preparedStatement.setString(2, book.getAuthor());
            preparedStatement.setDouble(3, book.getPrice());
            preparedStatement.setInt(4, book.getStockQuantity());
            preparedStatement.executeUpdate();
        }
    }

    public Book selectBook(int id) throws SQLException {
        Book book = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BOOK_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                book = new Book(
                        rs.getInt("book_id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity")
                );
            }
        }
        return book;
    }

    public List<Book> selectAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_BOOKS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                books.add(new Book(
                        rs.getInt("book_id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity")
                ));
            }
        }
        return books;
    }

    public boolean deleteBook(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_BOOK_SQL)) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateBook(Book book) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_BOOK_SQL)) {
            statement.setString(1, book.getTitle());
            statement.setString(2, book.getAuthor());
            statement.setDouble(3, book.getPrice());
            statement.setInt(4, book.getStockQuantity());
            statement.setInt(5, book.getBookId());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }
}
