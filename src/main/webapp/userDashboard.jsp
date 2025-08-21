<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Bookshop Billing Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    :root {
      --primary: #2563eb;
      --secondary: #1e293b;
      --light: #f8fafc;
      --dark: #0f172a;
      --gray: #64748b;
      --white: #ffffff;

      --green: #198754;
      --green-dark: #146c43;
      --ash: #37474f;
      --ash-light: #90a4ae;
      --bg: #f5f7f9;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: "Segoe UI", sans-serif;
    }

    body {
      background: var(--light);
      color: var(--dark);
    }

    /* Sidebar */
    .sidebar {
      height: 100vh;
      width: 240px;
      position: fixed;
      top: 0;
      left: 0;
      background-color: var(--secondary);
      color: var(--white);
      display: flex;
      flex-direction: column;
      padding: 20px 0;
    }
    .sidebar h2 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 22px;
      font-weight: 600;
    }
    .sidebar a {
      padding: 14px 25px;
      text-decoration: none;
      color: var(--white);
      display: block;
      transition: 0.3s;
      font-size: 15px;
    }
    .sidebar a:hover,
    .sidebar a.active {
      background-color: var(--primary);
      border-radius: 8px;
    }

    /* Navbar */
    .navbar {
      margin-left: 240px;
      height: 65px;
      background-color: var(--white);
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 25px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.08);
      position: sticky;
      top: 0;
      z-index: 1000;
    }
    .navbar h1 {
      font-size: 20px;
      font-weight: 600;
      color: var(--dark);
    }
    .navbar .profile {
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: 15px;
      font-weight: 500;
    }
    .navbar .profile img {
      width: 38px;
      height: 38px;
      border-radius: 50%;
      border: 2px solid var(--primary);
    }

    /* Main Content */
    .main-content {
      margin-left: 240px;
      padding: 25px;
      background: var(--bg);
      min-height: 100vh;
    }
    .main-content h2 {
      font-size: 22px;
      margin-bottom: 20px;
      font-weight: 600;
      color: var(--dark);
    }

    /* Section (from billing design) */
    .section {
      background: var(--white);
      border-radius: 12px;
      padding: 32px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.04);
      margin-bottom: 40px;
    }
    .section h2 {
      font-size: 18px;
      margin-bottom: 20px;
      color: var(--ash);
    }

    .form-row {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
      margin-bottom: 20px;
    }
    .form-group {
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    .form-group label {
      font-size: 15px;
      margin-bottom: 6px;
      color: #455a64;
    }
    .form-group input,
    .form-group select {
      padding: 12px 14px;
      font-size: 15px;
      border: 1px solid #cfd8dc;
      border-radius: 8px;
      background-color: white;
    }
    .form-group input:focus,
    .form-group select:focus {
      outline: none;
      border-color: var(--green);
      box-shadow: 0 0 0 2px rgba(25, 135, 84, 0.15);
    }

    .btn {
      padding: 12px 20px;
      background-color: var(--green);
      color: white;
      font-size: 15px;
      font-weight: 600;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background 0.3s ease;
    }
    .btn:hover {
      background-color: var(--green-dark);
    }

    table {
      width: 100%;
      font-size: 15px;
      margin-top: 20px;
      border-collapse: collapse;
    }
    th, td {
      padding: 14px;
      text-align: left;
      border-bottom: 1px solid #e0e0e0;
    }
    thead {
      background-color: #eceff1;
      color: var(--ash);
    }
    tbody tr:nth-child(even) {
      background-color: #f5f5f5;
    }
    .total-row td {
      font-weight: 600;
      font-size: 16px;
      text-align: right;
    }
    table button {
      padding: 6px 10px;
      font-size: 13px;
      margin-right: 6px;
      background-color: #ddd;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    table button:hover {
      background-color: #bbb;
    }
  </style>
</head>
<body>

  <!-- Sidebar -->
  <div class="sidebar">
    <h2>Bookshop</h2>
    <a href="#" class="active">🏠 Dashboard</a>
    <a href="#">📄 My Profile</a>
    <a href="#">🛒 Orders</a>
    <a href="#">📚 Billing</a>
    <a href="logout.jsp">🚪 Logout</a>
  </div>

  <!-- Navbar -->
  <div class="navbar">
    <h1>Welcome, <%= user.getUserName() %> 👋</h1>
    <div class="profile">
      <span><%= user.getRole() %></span>
      <img src="https://via.placeholder.com/40" alt="profile">
    </div>
  </div>

  <!-- Main Content -->
  <div class="main-content">

    <!-- Billing Sections -->
    <div class="section">
      <h2>Select Registered Customer</h2>
      <div class="form-row">
        <div class="form-group">
          <label for="customerId">Customer</label>
          <select id="customerId">
            <option disabled selected>-- Choose Customer --</option>
            <option value="CUST001">CUST001 - sam</option>
            <option value="CUST002">CUST002 - Smith</option>
          </select>
        </div>
      </div>
    </div>

    <div class="section">
      <h2>Add Book to Bill</h2>
      <div class="form-row">
        <div class="form-group">
          <label for="bookSelect">Book</label>
          <select id="bookSelect">
            <option disabled selected>-- Select Book --</option>
            <option value="Fiction" data-price="500">HTML & CSS</option>
            <option value="History" data-price="650">Java Programming</option>
            <option value="Python Basics" data-price="400">Python Basics</option>
          </select>
        </div>
        <div class="form-group">
          <label for="qty">Quantity</label>
          <input type="number" id="qty" min="1" value="1">
        </div>
      </div>
      <button class="btn" onclick="addToBill()">Add to Bill</button>
    </div>

    <div class="section">
      <h2>Bill Summary</h2>
      <table id="billTable">
        <thead>
          <tr>
            <th>Book</th>
            <th>Qty</th>
            <th>Price (LKR)</th>
            <th>Total (LKR)</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody id="billBody"></tbody>
        <tfoot>
          <tr class="total-row">
            <td colspan="4">Grand Total</td>
            <td id="grandTotal">₹0</td>
          </tr>
        </tfoot>
      </table>
      <br>
      <button class="btn">Generate Invoice</button>
    </div>

  </div>

  <script>
    let grandTotal = 0;

    function addToBill() {
      const book = document.getElementById("bookSelect");
      if (book.selectedIndex <= 0) return;
      const qty = parseInt(document.getElementById("qty").value);
      const price = parseInt(book.options[book.selectedIndex].dataset.price);
      const name = book.value;
      const total = qty * price;

      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${name}</td>
        <td>${qty}</td>
        <td>${price}</td>
        <td>${total}</td>
        <td>
          <button onclick="editRow(this)">Edit</button>
          <button onclick="deleteRow(this)">Delete</button>
        </td>
      `;
      document.getElementById("billBody").appendChild(row);
      grandTotal += total;
      updateTotal();

      book.selectedIndex = 0;
      document.getElementById("qty").value = 1;
    }

    function updateTotal() {
      document.getElementById("grandTotal").innerText = `LKR${grandTotal}`;
    }

    function deleteRow(button) {
      const row = button.closest("tr");
      const total = parseInt(row.cells[3].innerText.replace("LKR", ""));
      grandTotal -= total;
      row.remove();
      updateTotal();
    }

    function editRow(button) {
      const row = button.closest("tr");
      const name = row.cells[0].innerText;
      const qty = parseInt(row.cells[1].innerText);
      const price = parseInt(row.cells[2].innerText.replace("LRK", ""));

      const newQty = prompt(`Update quantity for "${name}":`, qty);
      const newPrice = prompt(`Update price for "${name}":`, price);

      if (newQty !== null && newPrice !== null && !isNaN(newQty) && !isNaN(newPrice)) {
        const oldTotal = parseInt(row.cells[3].innerText.replace("LKR", ""));
        const newTotal = parseInt(newQty) * parseInt(newPrice);

        row.cells[1].innerText = newQty;
        row.cells[2].innerText = `LKR${newPrice}`;
        row.cells[3].innerText = `LKR${newTotal}`;

        grandTotal = grandTotal - oldTotal + newTotal;
        updateTotal();
      }
    }
  </script>
</body>
</html>
