<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer List (Items)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f8f9fa; }
        h2 { color: #333; margin-bottom: 20px; }

        .btn { padding: 6px 12px; border-radius: 4px; text-decoration: none; }
        .add-btn { background: green; color: white; }
        .edit-btn { background: orange; color: white; }
        .delete-btn { background: red; color: white; }

        table { border-collapse: collapse; width: 100%; margin-top: 20px; background: #fff; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #4a6cf7; color: #fff; }

        .actions a { margin: 0 5px; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; }

    </style>
</head>
<body>


    <div class="top-bar">
        <h2><i class="fas fa-list-ul"></i> Customer List</h2>
        <a href="new" class="btn add-btn"><i class="fas fa-plus"></i> Add New Item</a>
    </div>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Category</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="item" items="${listItems}">
            <tr>
                <td>${item.itemID}</td>
                <td>${item.name}</td>
                <td>${item.category}</td>
                <td>${item.quantity}</td>
                <td>${item.price}</td>
                <td class="actions">
                    <a href="edit?id=${item.itemID}" class="btn edit-btn"><i class="fas fa-edit"></i> Edit</a>
                    <a href="delete?id=${item.itemID}" class="btn delete-btn"
                       onclick="return confirm('Are you sure you want to delete this item?');"><i class="fas fa-trash"></i> Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <br>
    <a href="adminDashboard.jsp" class="btn" style="background:#6c757d;color:#fff;">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</body>
</html>
