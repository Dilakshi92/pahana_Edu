<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Dark Theme Variables */
        :root {
            --primary-bg: #0a0e1a;
            --secondary-bg: #1a1f35;
            --accent-bg: #242b4d;
            --hover-bg: #2d3561;
            --text-primary: #ffffff;
            --text-secondary: #b8c5d6;
            --accent-color: #00d4ff;
            --success-color: #00ff88;
            --warning-color: #ffaa00;
            --danger-color: #ff4757;
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-accent: linear-gradient(135deg, #00d4ff 0%, #0099cc 100%);
            --gradient-danger: linear-gradient(135deg, #ff4757 0%, #ff3742 100%);
            --gradient-warning: linear-gradient(135deg, #ffaa00 0%, #ff8800 100%);
            --gradient-success: linear-gradient(135deg, #00ff88 0%, #00cc6a 100%);
            --shadow-glow: 0 8px 32px rgba(0, 212, 255, 0.2);
            --shadow-elevated: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: var(--primary-bg);
            color: var(--text-primary);
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            overflow-x: hidden;
            position: relative;
        }

        /* Animated Background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background:
                radial-gradient(circle at 20% 80%, rgba(0, 212, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(102, 126, 234, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(118, 75, 162, 0.1) 0%, transparent 50%);
            z-index: -1;
            animation: backgroundShift 20s ease-in-out infinite;
        }

        @keyframes backgroundShift {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        /* Container Styles */
        .main-container {
            min-height: 100vh;
            padding: 2rem;
            position: relative;
            z-index: 1;
        }

        .header-section {
            text-align: center;
            margin-bottom: 3rem;
            position: relative;
        }

        .header-title {
            font-size: 3.5rem;
            font-weight: 800;
            background: var(--gradient-accent);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1rem;
            text-shadow: 0 4px 20px rgba(0, 212, 255, 0.3);
            animation: titleGlow 3s ease-in-out infinite alternate;
        }

        @keyframes titleGlow {
            from { filter: drop-shadow(0 0 20px rgba(0, 212, 255, 0.3)); }
            to { filter: drop-shadow(0 0 30px rgba(0, 212, 255, 0.6)); }
        }

        .header-subtitle {
            font-size: 1.2rem;
            color: var(--text-secondary);
            font-weight: 300;
        }

        /* Card Styles */
        .management-card {
            background: rgba(26, 31, 53, 0.8);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(0, 212, 255, 0.2);
            border-radius: 24px;
            box-shadow: var(--shadow-elevated);
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            max-width: 1400px;
            margin: 0 auto;
        }

        .management-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.4);
            border-color: rgba(0, 212, 255, 0.4);
        }

        .card-header-custom {
            background: var(--gradient-primary);
            padding: 2rem;
            border-bottom: 1px solid rgba(0, 212, 255, 0.3);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .header-title-section h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .header-title-section p {
            color: rgba(255, 255, 255, 0.8);
            margin: 0;
            font-size: 0.95rem;
        }

        /* Add User Button */
        .add-user-btn {
            background: var(--gradient-accent);
            border: none;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-glow);
            position: relative;
            overflow: hidden;
        }

        .add-user-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .add-user-btn:hover::before {
            left: 100%;
        }

        .add-user-btn:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 40px rgba(0, 212, 255, 0.4);
        }

        /* Table Styles */
        .table-container {
            padding: 2rem;
            background: var(--secondary-bg);
        }

        .users-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: transparent;
            border-radius: 16px;
            overflow: hidden;
        }

        .users-table thead th {
            background: var(--accent-bg);
            color: var(--text-primary);
            padding: 1.5rem 1rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.85rem;
            border: none;
            position: relative;
        }

        .users-table thead th::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background: var(--gradient-accent);
        }

        .users-table tbody tr {
            background: rgba(36, 43, 77, 0.6);
            transition: all 0.3s ease;
            border-bottom: 1px solid rgba(0, 212, 255, 0.1);
        }

        .users-table tbody tr:hover {
            background: var(--hover-bg);
            transform: scale(1.02);
            box-shadow: 0 8px 25px rgba(0, 212, 255, 0.15);
        }

        .users-table tbody td {
            padding: 1.5rem 1rem;
            border: none;
            color: var(--text-primary);
            font-weight: 500;
            vertical-align: middle;
        }

        .user-id {
            font-weight: 700;
            color: var(--accent-color);
            font-size: 1.1rem;
        }

        .user-name {
            font-weight: 600;
            font-size: 1.05rem;
        }

        .user-email {
            color: var(--text-secondary);
            font-style: italic;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            justify-content: center;
        }

        .action-btn {
            padding: 0.75rem;
            border: none;
            border-radius: 12px;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 45px;
            position: relative;
            overflow: hidden;
        }

        .edit-btn {
            background: var(--gradient-warning);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 170, 0, 0.3);
        }

        .edit-btn:hover {
            transform: translateY(-3px) rotate(5deg);
            box-shadow: 0 8px 25px rgba(255, 170, 0, 0.5);
            color: white;
        }

        .delete-btn {
            background: var(--gradient-danger);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 71, 87, 0.3);
        }

        .delete-btn:hover {
            transform: translateY(-3px) rotate(-5deg);
            box-shadow: 0 8px 25px rgba(255, 71, 87, 0.5);
            color: white;
        }

        /* Modal Styles */
        .modal-content {
            background: var(--secondary-bg);
            border: 1px solid rgba(0, 212, 255, 0.3);
            border-radius: 20px;
            box-shadow: var(--shadow-elevated);
            backdrop-filter: blur(20px);
        }

        .modal-header {
            background: var(--gradient-primary);
            border-bottom: 1px solid rgba(0, 212, 255, 0.3);
            border-radius: 20px 20px 0 0;
            padding: 2rem;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
        }

        .modal-body {
            padding: 2rem;
            background: var(--secondary-bg);
        }

        .form-label {
            color: var(--text-primary);
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .form-control {
            background: rgba(36, 43, 77, 0.8);
            border: 2px solid rgba(0, 212, 255, 0.2);
            border-radius: 12px;
            color: var(--text-primary);
            padding: 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background: rgba(36, 43, 77, 1);
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(0, 212, 255, 0.2);
            color: var(--text-primary);
            transform: translateY(-2px);
        }

        .form-control::placeholder {
            color: var(--text-secondary);
        }

        .modal-footer {
            background: var(--secondary-bg);
            border-top: 1px solid rgba(0, 212, 255, 0.3);
            border-radius: 0 0 20px 20px;
            padding: 1.5rem 2rem;
        }

        .btn-modal-primary {
            background: var(--gradient-accent);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-modal-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-glow);
        }

        .btn-modal-success {
            background: var(--gradient-success);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-modal-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 255, 136, 0.4);
        }

        .btn-secondary {
            background: rgba(184, 197, 214, 0.2);
            border: 1px solid rgba(184, 197, 214, 0.3);
            color: var(--text-secondary);
            padding: 0.75rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: rgba(184, 197, 214, 0.3);
            color: var(--text-primary);
            border-color: rgba(184, 197, 214, 0.5);
        }

        /* Loading Animation */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(10, 14, 26, 0.9);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(0, 212, 255, 0.2);
            border-top: 4px solid var(--accent-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 4rem;
            color: rgba(0, 212, 255, 0.3);
            margin-bottom: 1rem;
        }

        .empty-state h4 {
            color: var(--text-primary);
            margin-bottom: 1rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
            }

            .header-title {
                font-size: 2.5rem;
            }

            .card-header-custom {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .users-table {
                font-size: 0.85rem;
            }

            .users-table thead th,
            .users-table tbody td {
                padding: 1rem 0.5rem;
            }

            .action-buttons {
                flex-direction: column;
                gap: 0.25rem;
            }
        }

        /* Pulse Animation for New Entries */
        .pulse-animation {
            animation: pulse 2s ease-in-out;
        }

        @keyframes pulse {
            0% { background-color: rgba(0, 212, 255, 0.2); }
            50% { background-color: rgba(0, 212, 255, 0.1); }
            100% { background-color: rgba(36, 43, 77, 0.6); }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--primary-bg);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--gradient-accent);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--accent-color);
        }
    </style>
</head>
<body>
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner"></div>
    </div>

    <div class="main-container">
        <div class="header-section">
            <h1 class="header-title">
                <i class="fas fa-users-cog"></i> User Management
            </h1>
            <p class="header-subtitle">Manage your customers with style and efficiency</p>
        </div>

        <div class="management-card">
            <div class="card-header-custom">
                <div class="header-title-section">
                    <h3>
                        <i class="fas fa-database"></i>
                        Customer Database
                    </h3>
                    <p>Total Users: <span id="userCount">${listCustomers.size()}</span></p>
                </div>
                <button class="btn add-user-btn" data-bs-toggle="modal" data-bs-target="#addUserModal">
                    <i class="fas fa-plus"></i> Add New User
                </button>
            </div>

            <div class="table-container">
                <c:choose>
                    <c:when test="${empty listCustomers}">
                        <div class="empty-state">
                            <i class="fas fa-users"></i>
                            <h4>No Users Found</h4>
                            <p>Start by adding your first customer to the database.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="users-table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-hashtag"></i> ID</th>
                                    <th><i class="fas fa-user"></i> Name</th>
                                    <th><i class="fas fa-envelope"></i> Email</th>
                                    <th><i class="fas fa-phone"></i> Phone</th>
                                    <th><i class="fas fa-map-marker-alt"></i> Address</th>
                                    <th><i class="fas fa-cogs"></i> Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="customer" items="${listCustomers}">
                                    <tr>
                                        <td class="user-id">#${customer.id}</td>
                                        <td class="user-name">${customer.name}</td>
                                        <td class="user-email">${customer.email}</td>
                                        <td>${customer.phone}</td>
                                        <td>${customer.address}</td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="#" class="action-btn edit-btn"
                                                   data-bs-toggle="modal" data-bs-target="#editUserModal"
                                                   data-id="${customer.id}"
                                                   data-name="${customer.name}"
                                                   data-email="${customer.email}"
                                                   data-phone="${customer.phone}"
                                                   data-address="${customer.address}"
                                                   title="Edit User">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="manage-customers?action=delete&id=${customer.id}"
                                                   class="action-btn delete-btn"
                                                   onclick="return confirmDelete('${customer.name}')"
                                                   title="Delete User">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="manage-customers?action=insert" method="post" id="addUserForm">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addUserModalLabel">
                            <i class="fas fa-user-plus"></i> Add New User
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="addName" class="form-label">
                                    <i class="fas fa-user"></i> Full Name
                                </label>
                                <input type="text" class="form-control" id="addName" name="name" required placeholder="Enter full name">
                            </div>
                            <div class="col-md-6">
                                <label for="addEmail" class="form-label">
                                    <i class="fas fa-envelope"></i> Email Address
                                </label>
                                <input type="email" class="form-control" id="addEmail" name="email" required placeholder="Enter email address">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="addPhone" class="form-label">
                                    <i class="fas fa-phone"></i> Phone Number
                                </label>
                                <input type="tel" class="form-control" id="addPhone" name="phone" required placeholder="Enter phone number">
                            </div>
                            <div class="col-md-6">
                                <label for="addAddress" class="form-label">
                                    <i class="fas fa-map-marker-alt"></i> Address
                                </label>
                                <input type="text" class="form-control" id="addAddress" name="address" required placeholder="Enter address">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-modal-primary">
                            <i class="fas fa-plus"></i> Add User
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="manage-customers?action=update" method="post" id="editUserForm">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editUserModalLabel">
                            <i class="fas fa-user-edit"></i> Edit User
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="id" id="editId">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="editName" class="form-label">
                                    <i class="fas fa-user"></i> Full Name
                                </label>
                                <input type="text" class="form-control" id="editName" name="name" required>
                            </div>
                            <div class="col-md-6">
                                <label for="editEmail" class="form-label">
                                    <i class="fas fa-envelope"></i> Email Address
                                </label>
                                <input type="email" class="form-control" id="editEmail" name="email" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="editPhone" class="form-label">
                                    <i class="fas fa-phone"></i> Phone Number
                                </label>
                                <input type="tel" class="form-control" id="editPhone" name="phone" required>
                            </div>
                            <div class="col-md-6">
                                <label for="editAddress" class="form-label">
                                    <i class="fas fa-map-marker-alt"></i> Address
                                </label>
                                <input type="text" class="form-control" id="editAddress" name="address" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-modal-success">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Loading overlay functions
        function showLoading() {
            document.getElementById('loadingOverlay').style.display = 'flex';
        }

        function hideLoading() {
            document.getElementById('loadingOverlay').style.display = 'none';
        }

        // Enhanced delete confirmation
        function confirmDelete(userName) {
            return confirm(`⚠️ Are you sure you want to delete user "${userName}"?\n\nThis action cannot be undone.`);
        }

        // Form submission with loading
        document.getElementById('addUserForm').addEventListener('submit', function() {
            showLoading();
        });

        document.getElementById('editUserForm').addEventListener('submit', function() {
            showLoading();
        });

        // Fill edit modal with user data
        document.querySelectorAll('.edit-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.getElementById('editId').value = this.getAttribute('data-id');
                document.getElementById('editName').value = this.getAttribute('data-name');
                document.getElementById('editEmail').value = this.getAttribute('data-email');
                document.getElementById('editPhone').value = this.getAttribute('data-phone');
                document.getElementById('editAddress').value = this.getAttribute('data-address');
            });
        });

        // Add pulse animation to new entries (if needed)
        function addPulseToNewEntry(rowId) {
            const row = document.querySelector(`tr[data-id="${rowId}"]`);
            if (row) {
                row.classList.add('pulse-animation');
                setTimeout(() => {
                    row.classList.remove('pulse-animation');
                }, 2000);
            }
        }

        // Enhanced form validation
        function validateForm(form) {
            const inputs = form.querySelectorAll('input[required]');
            let isValid = true;

            inputs.forEach(input => {
                if (!input.value.trim()) {
                    input.classList.add('is-invalid');
                    isValid = false;
                } else {
                    input.classList.remove('is-invalid');
                }
            });

            return isValid;
        }

        // Email validation
        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }

        // Phone validation
        function validatePhone(phone) {
            const re = /^[\+]?[1-9][\d]{0,15}$/;
            return re.test(phone.replace(/\s/g, ''));
        }

        // Real-time validation
        document.querySelectorAll('input[type="email"]').forEach(input => {
            input.addEventListener('blur', function() {
                if (this.value && !validateEmail(this.value)) {
                    this.classList.add('is-invalid');
                    this.style.borderColor = 'var(--danger-color)';
                } else {
                    this.classList.remove('is-invalid');
                    this.style.borderColor = '';
                }
            });
        });

        document.querySelectorAll('input[type="tel"]').forEach(input => {
            input.addEventListener('blur', function() {
                if (this.value && !validatePhone(this.value)) {
                    this.classList.add('is-invalid');
                    this.style.borderColor = 'var(--danger-color)';
                } else {
                    this.classList.remove('is-invalid');
                    this.style.borderColor = '';
                }
            });
        });

        // Search functionality
        function initializeSearch() {
            const searchContainer = document.createElement('div');
            searchContainer.className = 'search-container mb-4';
            searchContainer.innerHTML = `
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" id="userSearch" class="search-input" placeholder="Search users by name, email, or phone...">
                    <button type="button" class="search-clear" id="clearSearch" style="display: none;">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            `;

            const tableContainer = document.querySelector('.table-container');
            tableContainer.insertBefore(searchContainer, tableContainer.firstChild);

            // Add search styles
            const searchStyles = `
                <style>
                    .search-container {
                        padding: 0 0 2rem 0;
                    }

                    .search-box {
                        position: relative;
                        max-width: 500px;
                        margin: 0 auto;
                    }

                    .search-input {
                        width: 100%;
                        padding: 1rem 3rem 1rem 3rem;
                        background: rgba(36, 43, 77, 0.8);
                        border: 2px solid rgba(0, 212, 255, 0.2);
                        border-radius: 50px;
                        color: var(--text-primary);
                        font-size: 1rem;
                        transition: all 0.3s ease;
                    }

                    .search-input:focus {
                        outline: none;
                        border-color: var(--accent-color);
                        box-shadow: 0 0 0 3px rgba(0, 212, 255, 0.2);
                        background: rgba(36, 43, 77, 1);
                    }

                    .search-icon {
                        position: absolute;
                        left: 1rem;
                        top: 50%;
                        transform: translateY(-50%);
                        color: var(--text-secondary);
                        font-size: 1.1rem;
                    }

                    .search-clear {
                        position: absolute;
                        right: 1rem;
                        top: 50%;
                        transform: translateY(-50%);
                        background: var(--gradient-danger);
                        border: none;
                        border-radius: 50%;
                        width: 30px;
                        height: 30px;
                        color: white;
                        cursor: pointer;
                        transition: all 0.3s ease;
                    }

                    .search-clear:hover {
                        transform: translateY(-50%) scale(1.1);
                    }

                    .no-results {
                        text-align: center;
                        padding: 3rem 2rem;
                        color: var(--text-secondary);
                    }

                    .no-results i {
                        font-size: 3rem;
                        color: rgba(0, 212, 255, 0.3);
                        margin-bottom: 1rem;
                    }
                </style>
            `;
            document.head.insertAdjacentHTML('beforeend', searchStyles);

            // Search functionality
            const searchInput = document.getElementById('userSearch');
            const clearButton = document.getElementById('clearSearch');
            const tableRows = document.querySelectorAll('.users-table tbody tr');

            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase().trim();
                let visibleCount = 0;

                if (searchTerm) {
                    clearButton.style.display = 'block';
                } else {
                    clearButton.style.display = 'none';
                }

                tableRows.forEach(row => {
                    const name = row.cells[1].textContent.toLowerCase();
                    const email = row.cells[2].textContent.toLowerCase();
                    const phone = row.cells[3].textContent.toLowerCase();

                    if (name.includes(searchTerm) || email.includes(searchTerm) || phone.includes(searchTerm)) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });

                // Show/hide no results message
                const existingNoResults = document.querySelector('.no-results');
                if (existingNoResults) {
                    existingNoResults.remove();
                }

                if (visibleCount === 0 && searchTerm) {
                    const noResultsDiv = document.createElement('div');
                    noResultsDiv.className = 'no-results';
                    noResultsDiv.innerHTML = `
                        <i class="fas fa-search"></i>
                        <h4>No Results Found</h4>
                        <p>No users match your search criteria for "<strong>${searchTerm}</strong>"</p>
                    `;
                    document.querySelector('.users-table').after(noResultsDiv);
                }
            });

            clearButton.addEventListener('click', function() {
                searchInput.value = '';
                searchInput.dispatchEvent(new Event('input'));
                searchInput.focus();
            });
        }

        // Statistics and counters
        function updateStatistics() {
            const totalUsers = document.querySelectorAll('.users-table tbody tr').length;
            const userCountElement = document.getElementById('userCount');
            if (userCountElement) {
                userCountElement.textContent = totalUsers;
            }
        }

        // Toast notifications
        function showToast(message, type = 'success') {
            // Remove existing toasts
            const existingToasts = document.querySelectorAll('.custom-toast');
            existingToasts.forEach(toast => toast.remove());

            const toast = document.createElement('div');
            toast.className = `custom-toast ${type}`;

            const icon = type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-triangle' : 'info-circle';

            toast.innerHTML = `
                <i class="fas fa-${icon}"></i>
                <span>${message}</span>
                <button class="toast-close"><i class="fas fa-times"></i></button>
            `;

            // Add toast styles
            const toastStyles = `
                <style>
                    .custom-toast {
                        position: fixed;
                        top: 2rem;
                        right: 2rem;
                        background: var(--secondary-bg);
                        border: 1px solid rgba(0, 212, 255, 0.3);
                        border-radius: 12px;
                        padding: 1rem 1.5rem;
                        color: var(--text-primary);
                        display: flex;
                        align-items: center;
                        gap: 1rem;
                        z-index: 10000;
                        box-shadow: var(--shadow-elevated);
                        backdrop-filter: blur(20px);
                        animation: slideInRight 0.3s ease;
                        max-width: 400px;
                    }

                    .custom-toast.success {
                        border-left: 4px solid var(--success-color);
                    }

                    .custom-toast.error {
                        border-left: 4px solid var(--danger-color);
                    }

                    .custom-toast.info {
                        border-left: 4px solid var(--accent-color);
                    }

                    .custom-toast i:first-child {
                        font-size: 1.2rem;
                        color: var(--accent-color);
                    }

                    .custom-toast.success i:first-child {
                        color: var(--success-color);
                    }

                    .custom-toast.error i:first-child {
                        color: var(--danger-color);
                    }

                    .toast-close {
                        background: none;
                        border: none;
                        color: var(--text-secondary);
                        cursor: pointer;
                        padding: 0;
                        margin-left: auto;
                        font-size: 1rem;
                    }

                    .toast-close:hover {
                        color: var(--text-primary);
                    }

                    @keyframes slideInRight {
                        from {
                            transform: translateX(100%);
                            opacity: 0;
                        }
                        to {
                            transform: translateX(0);
                            opacity: 1;
                        }
                    }

                    @keyframes slideOutRight {
                        from {
                            transform: translateX(0);
                            opacity: 1;
                        }
                        to {
                            transform: translateX(100%);
                            opacity: 0;
                        }
                    }
                </style>
            `;

            if (!document.querySelector('#toast-styles')) {
                const style = document.createElement('style');
                style.id = 'toast-styles';
                style.textContent = toastStyles.replace(/<\/?style>/g, '');
                document.head.appendChild(style);
            }

            document.body.appendChild(toast);

            // Close button functionality
            toast.querySelector('.toast-close').addEventListener('click', function() {
                toast.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => toast.remove(), 300);
            });

            // Auto-remove after 5 seconds
            setTimeout(() => {
                if (toast.parentElement) {
                    toast.style.animation = 'slideOutRight 0.3s ease';
                    setTimeout(() => toast.remove(), 300);
                }
            }, 5000);
        }

        // Enhanced modal animations
        function enhanceModals() {
            const modals = document.querySelectorAll('.modal');
            modals.forEach(modal => {
                modal.addEventListener('show.bs.modal', function() {
                    this.querySelector('.modal-dialog').style.transform = 'scale(0.8)';
                    this.querySelector('.modal-dialog').style.opacity = '0';

                    setTimeout(() => {
                        this.querySelector('.modal-dialog').style.transition = 'all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1)';
                        this.querySelector('.modal-dialog').style.transform = 'scale(1)';
                        this.querySelector('.modal-dialog').style.opacity = '1';
                    }, 10);
                });

                modal.addEventListener('hide.bs.modal', function() {
                    this.querySelector('.modal-dialog').style.transition = 'all 0.2s ease';
                    this.querySelector('.modal-dialog').style.transform = 'scale(0.9)';
                    this.querySelector('.modal-dialog').style.opacity = '0';
                });
            });
        }

        // Keyboard shortcuts
        function initializeKeyboardShortcuts() {
            document.addEventListener('keydown', function(e) {
                // Ctrl/Cmd + K to open search
                if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                    e.preventDefault();
                    const searchInput = document.getElementById('userSearch');
                    if (searchInput) {
                        searchInput.focus();
                        searchInput.select();
                    }
                }

                // Ctrl/Cmd + N to add new user
                if ((e.ctrlKey || e.metaKey) && e.key === 'n') {
                    e.preventDefault();
                    const addButton = document.querySelector('[data-bs-target="#addUserModal"]');
                    if (addButton) {
                        addButton.click();
                    }
                }

                // Escape to close modals
                if (e.key === 'Escape') {
                    const openModals = document.querySelectorAll('.modal.show');
                    openModals.forEach(modal => {
                        bootstrap.Modal.getInstance(modal)?.hide();
                    });
                }
            });
        }

        // Initialize everything when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Hide loading overlay
            hideLoading();

            // Initialize features if there are users
            if (document.querySelector('.users-table')) {
                initializeSearch();
            }

            updateStatistics();
            enhanceModals();
            initializeKeyboardShortcuts();

            // Show welcome message
            setTimeout(() => {
                showToast('User Management System loaded successfully!', 'success');
            }, 500);
        });

        // Form submission enhancements
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function(e) {
                if (!validateForm(this)) {
                    e.preventDefault();
                    showToast('Please fill in all required fields correctly.', 'error');
                    return false;
                }

                showLoading();
                showToast('Processing your request...', 'info');
            });
        });
    </script>
</body>
</html>