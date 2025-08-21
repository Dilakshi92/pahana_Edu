<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Item Details</title>
</head>
<body>
    <h1>Item Details</h1>
    <p><strong>ID:</strong> ${item.itemID}</p>
    <p><strong>Name:</strong> ${item.name}</p>
    <p><strong>Category:</strong> ${item.category}</p>
    <p><strong>Quantity:</strong> ${item.quantity}</p>
    <p><strong>Price:</strong> ${item.price}</p>

    <a href="stock?action=edit&id=${item.itemID}">Edit</a>
    <a href="stock?action=list">Back to List</a>
</body>
</html>