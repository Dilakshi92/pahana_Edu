<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Admin" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --info: #560bad;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', system-ui, -apple-system, sans-serif;
        }

        body {
            background-color: #f5f7ff;
            color: var(--dark);
            min-height: 100vh;
        }

        .dashboard-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            background: linear-gradient(180deg, var(--primary), var(--secondary));
            color: white;
            padding: 2rem 1.5rem;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 2.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .brand i {
            font-size: 1.75rem;
        }

        .brand h1 {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 2rem;
            padding: 0.75rem;
            border-radius: 0.5rem;
            background: rgba(255,255,255,0.1);
        }

        .user-profile i {
            font-size: 1.25rem;
            background: var(--accent);
            padding: 0.75rem;
            border-radius: 50%;
        }

        .user-info h3 {
            font-size: 0.9rem;
            font-weight: 500;
        }

        .user-info p {
            font-size: 0.8rem;
            opacity: 0.8;
        }

        .nav-menu {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            color: white;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .nav-item:hover, .nav-item.active {
            background: rgba(255,255,255,0.2);
        }

        .nav-item i {
            width: 1.5rem;
            text-align: center;
        }

        .logout-btn {
            margin-top: auto;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255,255,255,0.1);
        }

        /* Main Content Styles */
        .main-content {
            padding: 2rem;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            border-left: 4px solid var(--primary);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-icon {
            width: 2.5rem;
            height: 2.5rem;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .stat-icon.users {
            background: var(--success);
        }

        .stat-icon.books {
            background: var(--warning);
        }

        .stat-icon.customers {
            background: var(--danger);
        }

        .stat-icon.requests {
            background: var(--info);
        }

        .stat-value {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--dark);
        }

        .stat-title {
            font-size: 0.9rem;
            color: #6c757d;
        }

        .actions-section {
            background: white;
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--dark);
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .action-card {
            background: white;
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            border: 1px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px rgba(0,0,0,0.1);
            border-color: var(--accent);
        }

        .action-card a {
            display: flex;
            align-items: center;
            gap: 1rem;
            text-decoration: none;
            color: var(--dark);
        }

        .action-icon {
            width: 3rem;
            height: 3rem;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
        }

        .action-icon.users {
            background: var(--success);
        }

        .action-icon.books {
            background: var(--warning);
        }

        .action-icon.form {
            background: var(--danger);
        }

        .action-icon.list {
            background: var(--info);
        }

        .action-text h3 {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .action-text p {
            font-size: 0.8rem;
            color: #6c757d;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 1.5rem;
            border-radius: 0.5rem;
            width: 350px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            position: relative;
        }

        .close-modal {
            position: absolute;
            top: 0.5rem;
            right: 1rem;
            font-size: 1.5rem;
            color: #aaa;
            cursor: pointer;
        }

        .close-modal:hover {
            color: var(--danger);
        }

        .modal h3 {
            font-size: 1.1rem;
            margin-bottom: 1rem;
            color: var(--dark);
            text-align: center;
        }

        .modal-actions {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .modal-btn {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            background: var(--light);
            border-radius: 0.5rem;
            text-decoration: none;
            color: var(--dark);
            transition: all 0.2s ease;
            font-size: 0.9rem;
        }

        .modal-btn:hover {
            background: var(--primary);
            color: white;
        }

        .modal-btn i {
            width: 1.25rem;
            text-align: center;
        }
    </style>
</head>
<body>
    <%
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="brand">
                <i class="fas fa-shield-alt"></i>
                <h1>Admin Panel</h1>
            </div>

            <div class="user-profile">
                <i class="fas fa-user-cog"></i>
                <div class="user-info">
                    <h3><%= admin.getAdminName() %></h3>
                    <p>Administrator</p>
                </div>
            </div>

            <div class="nav-menu">
                <a href="adminDashboard.jsp" class="nav-item active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
                <a href="manageUsers.jsp" class="nav-item" id="manageUsersBtn">
                    <i class="fas fa-users-cog"></i>
                    <span>Manage Users</span>
                </a>

                <a href="manageBooks.jsp" class="nav-item">
                    <i class="fas fa-book"></i>
                    <span>Manage Books</span>
                </a>
                <a href="item-form.jsp" class="nav-item">
                    <i class="fas fa-user-edit"></i>
                    <span>Customer Form</span>
                </a>
                <a href="item-list.jsp" class="nav-item">
                    <i class="fas fa-list-ul"></i>
                    <span>Customer List</span>
                </a>

                <div class="logout-btn">
                    <a href="logout.jsp" class="nav-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <div class="page-title">
                    <h2>Dashboard Overview</h2>
                </div>
                <div class="header-actions">
                    <!-- Can add search or other header actions here -->
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-header">
                        <div>
                            <p class="stat-title">Total Users</p>
                            <p class="stat-value">1,245</p>
                        </div>
                        <div class="stat-icon users">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div>
                            <p class="stat-title">Total Books</p>
                            <p class="stat-value">5,678</p>
                        </div>
                        <div class="stat-icon books">
                            <i class="fas fa-book-open"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div>
                            <p class="stat-title">Active Customers</p>
                            <p class="stat-value">892</p>
                        </div>
                        <div class="stat-icon customers">
                            <i class="fas fa-user-check"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div>
                            <p class="stat-title">Pending Requests</p>
                            <p class="stat-value">23</p>
                        </div>
                        <div class="stat-icon requests">
                            <i class="fas fa-clock"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="actions-section">
                <h3 class="section-title">Quick Actions</h3>

                <div class="actions-grid">
                    <div class="action-card">
                        <a href="manageUsers.jsp" id="quickManageUsersBtn">
                            <div class="action-icon users">
                                <i class="fas fa-users-cog"></i>
                            </div>
                            <div class="action-text">
                                <h3>Manage Users</h3>
                                <p>Add, edit or remove users</p>
                            </div>
                        </a>
                    </div>

                    <div class="action-card">
                        <a href="manageBooks.jsp">
                            <div class="action-icon books">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="action-text">
                                <h3>Manage Books</h3>
                                <p>Update book catalog</p>
                            </div>
                        </a>
                    </div>

                    <div class="action-card">
                        <a href="item-form.jsp">
                            <div class="action-icon form">
                                <i class="fas fa-user-edit"></i>
                            </div>
                            <div class="action-text">
                                <h3>Customer Form</h3>
                                <p>Create new customer records</p>
                            </div>
                        </a>
                    </div>

                    <div class="action-card">
                        <a href="item-list.jsp">
                            <div class="action-icon list">
                                <i class="fas fa-list-ul"></i>
                            </div>
                            <div class="action-text">
                                <h3>Customer List</h3>
                                <p>View all customers</p>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>



</body>
</html>