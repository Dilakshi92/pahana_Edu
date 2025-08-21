<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%
    List<Book> listBook = (List<Book>) request.getAttribute("listBook");
    Book book = (Book) request.getAttribute("book");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Books</title>
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5rem;
            font-weight: 300;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        h3 {
            color: #34495e;
            margin: 40px 0 20px 0;
            font-size: 1.8rem;
            font-weight: 400;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
        }

        /* Form Styles */
        .book-form {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 40px;
            border: 1px solid #dee2e6;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        input[type="text"],
        input[type="number"] {
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            transform: translateY(-2px);
        }

        .submit-btn {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
            background: linear-gradient(135deg, #2980b9 0%, #3498db 100%);
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        /* Table Styles */
        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            background: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
        }

        th {
            background: linear-gradient(135deg, #34495e 0%, #2c3e50 100%);
            color: white;
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #f1f2f6;
            vertical-align: middle;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #e3f2fd;
            transform: scale(1.01);
            transition: all 0.2s ease;
        }

        /* Action Links */
        .action-links {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .action-link {
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .edit-link {
            background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(243, 156, 18, 0.3);
        }

        .edit-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(243, 156, 18, 0.4);
        }

        .delete-link {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
        }

        .delete-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                margin: 10px;
                padding: 20px;
            }

            h2 {
                font-size: 2rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .action-links {
                flex-direction: column;
                gap: 8px;
            }

            .action-link {
                text-align: center;
                min-width: 80px;
            }
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            font-style: italic;
        }

        /* Price and Stock Styling */
        .price {
            font-weight: 600;
            color: #27ae60;
        }

        .stock {
            font-weight: 600;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.85rem;
        }

        .stock.low {
            background-color: #fee;
            color: #e74c3c;
        }

        .stock.medium {
            background-color: #fff3cd;
            color: #f39c12;
        }

        .stock.high {
            background-color: #d1ecf1;
            color: #17a2b8;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>📚 Book Management System</h2>

        <form action="books" method="post" class="book-form">
            <input type="hidden" name="action" value="<%= (book != null) ? "update" : "insert" %>"/>
            <input type="hidden" name="id" value="<%= (book != null) ? book.getBookId() : "" %>"/>

            <div class="form-grid">
                <div class="form-group">
                    <label for="title">📖 Title</label>
                    <input type="text" id="title" name="title" value="<%= (book != null) ? book.getTitle() : "" %>" required/>
                </div>

                <div class="form-group">
                    <label for="author">✍️ Author</label>
                    <input type="text" id="author" name="author" value="<%= (book != null) ? book.getAuthor() : "" %>" required/>
                </div>

                <div class="form-group">
                    <label for="price">💰 Price</label>
                    <input type="number" id="price" step="0.01" name="price" value="<%= (book != null) ? book.getPrice() : "" %>" required/>
                </div>

                <div class="form-group">
                    <label for="stock">📦 Stock Quantity</label>
                    <input type="number" id="stock" name="stock_quantity" value="<%= (book != null) ? book.getStockQuantity() : "" %>" required/>
                </div>
            </div>

            <div style="text-align: center;">
                <input type="submit" class="submit-btn" value="<%= (book != null) ? "Update Book" : "Add Book" %>"/>
            </div>
        </form>

        <h3>📋 Book Inventory</h3>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <% if(listBook != null && !listBook.isEmpty()){
                    for(Book b : listBook){
                        String stockClass = "";
                        int stock = b.getStockQuantity();
                        if(stock <= 5) stockClass = "low";
                        else if(stock <= 20) stockClass = "medium";
                        else stockClass = "high";
                %>
                    <tr>
                        <td><strong>#<%= b.getBookId() %></strong></td>
                        <td><%= b.getTitle() %></td>
                        <td><%= b.getAuthor() %></td>
                        <td class="price">$<%= String.format("%.2f", b.getPrice()) %></td>
                        <td><span class="stock <%= stockClass %>"><%= b.getStockQuantity() %></span></td>
                        <td>
                            <div class="action-links">
                                <a href="books?action=edit&id=<%=b.getBookId()%>" class="action-link edit-link">✏️ Edit</a>
                                <a href="books?action=delete&id=<%=b.getBookId()%>" class="action-link delete-link"
                                   onclick="return confirm('⚠️ Are you sure you want to delete this book?')">🗑️ Delete</a>
                            </div>
                        </td>
                    </tr>
                <% }
                } else { %>
                    <tr>
                        <td colspan="6" class="empty-state">
                            📭 No books found. Add your first book above!
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Add some interactive functionality
        document.addEventListener('DOMContentLoaded', function() {
            // Add loading state to submit button
            const form = document.querySelector('.book-form');
            const submitBtn = document.querySelector('.submit-btn');

            form.addEventListener('submit', function() {
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<span class="loading"></span> Processing...';
            });

            // Add confirmation for delete with more details
            document.querySelectorAll('.delete-link').forEach(link => {
                link.addEventListener('click', function(e) {
                    const row = this.closest('tr');
                    const title = row.cells[1].textContent;
                    const confirmMsg = `Are you sure you want to delete "${title}"?\n\nThis action cannot be undone.`;

                    if (!confirm(confirmMsg)) {
                        e.preventDefault();
                        return false;
                    }
                });
            });
        });
    </script>
</body>
</html>