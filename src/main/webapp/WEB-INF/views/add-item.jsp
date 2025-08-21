<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Item</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        form { max-width: 400px; margin: auto; }
        label { display: block; margin-top: 10px; }
        input { width: 100%; padding: 8px; margin-top: 5px; }
        button { margin-top: 15px; padding: 8px 15px; background: green; color: white; border: none; border-radius: 4px; }
        a { display: inline-block; margin-top: 15px; color: blue; text-decoration: none; }
    </style>
</head>
<body>
    <h2>Add New Item</h2>
    <form action="insert" method="post">
        <label>Name:</label>
        <input type="text" name="name" required>

        <label>Category:</label>
        <input type="text" name="category" required>

        <label>Quantity:</label>
        <input type="number" name="quantity" required>

        <label>Price:</label>
        <input type="number" step="0.01" name="price" required>

        <button type="submit">Save</button>
    </form>
    <a href="list">Back to List</a>
</body>
</html>
