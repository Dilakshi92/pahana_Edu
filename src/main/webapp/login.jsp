<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Bookshop Billing Login</title>
  <style>
    /* Reset */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Merriweather', serif;
      background-color: #f5f3ef;
      background-image: radial-gradient(circle, #eae6df 1px, transparent 1px),
                        radial-gradient(circle, #eae6df 1px, transparent 1px);
      background-size: 20px 20px;
      background-position: 0 0, 10px 10px;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .wrapper {
      display: flex;
      flex-direction: row;
      background-color: #ffffff;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      max-width: 900px;
      width: 100%;
    }

    .image-side {
      flex: 1;
      background-image: url('https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=800&q=80');
      background-size: cover;
      background-position: center;
      min-height: 100%;
    }

    .login-container {
      flex: 1;
      padding: 50px 40px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      background-color: #fff;
    }

    .login-container .logo {
      font-size: 2em;
      font-weight: bold;
      color: #4b3f2f;
      margin-bottom: 10px;
    }

    .login-container .subtitle {
      font-size: 1em;
      color: #7a6e5a;
      margin-bottom: 30px;
    }

    form {
      display: flex;
      flex-direction: column;
      gap: 20px;
      max-width: 400px;
      width: 100%;
    }

    .form-group {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    label {
      font-weight: 600;
      color: #4b3f2f;
    }

    input, select {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 1em;
      background-color: #f9f9f9;
      color: #333;
    }

    input:focus, select:focus {
      outline: none;
      border-color: #8b6f47;
    }

    button {
      padding: 12px;
      background-color: #8b6f47;
      color: white;
      border: none;
      border-radius: 8px;
      font-weight: bold;
      font-size: 1em;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #6f5736;
    }

    .footer {
      margin-top: 30px;
      font-size: 0.85em;
      color: #aaa;
      text-align: center;
    }

    .error {
      color: #d32f2f;
      background-color: #fde8e8;
      padding: 10px;
      border-radius: 8px;
      font-size: 0.9em;
      margin-bottom: 20px;
    }

    @media (max-width: 768px) {
      .wrapper {
        flex-direction: column;
      }

      .image-side {
        height: 200px;
      }
    }
  </style>
</head>
<body>
  <div class="wrapper">
    <div class="image-side"></div>
    <div class="login-container">
      <div class="logo">📚 Pahana Edu Bookshop Billing</div>
      <div class="subtitle">Welcome back. Please log in to continue.</div>

      <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error"><%= request.getAttribute("errorMessage") %></div>
      <% } %>

      <form action="login" method="post">
        <div class="form-group">
          <label for="userType">Login as:</label>
          <select id="userType" name="userType" required>
            <option value="admin">Admin</option>
            <option value="user">User</option>
          </select>
        </div>

        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" name="username" required />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" required />
        </div>

        <button type="submit">Login</button>
      </form>

      <div class="footer">© 2025 Pahana Edu Bookshop Billing System</div>
    </div>
  </div>
</body>
</html>