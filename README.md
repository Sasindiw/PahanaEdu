# 📚 PahanaEdu Bookshop Management System

A modern, user-friendly Java web application for managing a bookshop with comprehensive customer, item, and billing management features.

![Java](https://img.shields.io/badge/Java-11+-orange)
![Tomcat](https://img.shields.io/badge/Tomcat-9.0+-red)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-12+-blue)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.1.3-purple)

## 🎯 What is PahanaEdu?

PahanaEdu is a complete bookshop management system that helps you:
- **Manage Customers** - Add, edit, delete, and view customer information
- **Manage Items** - Track books, prices, stock levels, and categories
- **Create Bills** - Generate professional invoices for customers
- **User Authentication** - Secure login system with session management
- **Responsive Design** - Works perfectly on desktop, tablet, and mobile devices

## ✨ Key Features

### 🔐 User Management
- Secure login/logout system
- Session-based authentication
- User role management

### 👥 Customer Management
- Add new customers with account numbers
- Edit customer information (name, address, phone)
- View all customers in a searchable list
- Delete customers with confirmation

### 📦 Item Management
- Add new items with codes, names, descriptions
- Set prices and track stock levels
- Organize items by categories
- Edit item details with success alerts
- Delete items with confirmation

### 🧾 Billing System
- Create bills for customers
- Add multiple items to bills
- Automatic total calculation
- Professional bill printing
- Bill history tracking

### 🎨 User Interface
- Modern, responsive design
- Intuitive navigation sidebar
- Bootstrap 5 styling
- Font Awesome icons
- Mobile-friendly layout

## 🚀 Quick Start Guide

### Prerequisites

Before you begin, make sure you have the following installed:

- **Java 11 or higher** - [Download Java](https://adoptium.net/)
- **Apache Tomcat 9.0 or higher** - [Download Tomcat](https://tomcat.apache.org/)
- **PostgreSQL 12 or higher** - [Download PostgreSQL](https://www.postgresql.org/download/)
- **IntelliJ IDEA** (recommended) - [Download IntelliJ](https://www.jetbrains.com/idea/)

### 📋 Installation Steps

#### Step 1: Database Setup

1. **Create Database**
   ```sql
   CREATE DATABASE pahanaedu_bookshop;
   ```

2. **Run Setup Script**
   ```bash
   psql -U postgres -d pahanaedu_bookshop -f database_setup.sql
   ```

#### Step 2: Configure Database Connection

1. Open `src/com/pahanaedu/util/DatabaseConnection.java`
2. Update the connection details:
   ```java
   // Update these values to match your setup
   private static final String URL = "jdbc:postgresql://localhost:5432/pahanaedu_bookshop";
   private static final String USERNAME = "postgres";
   private static final String PASSWORD = "your_password_here";
   ```

#### Step 3: Build the Project

**Option A: Using IntelliJ IDEA (Recommended)**
1. Open the project in IntelliJ IDEA
2. Go to **Build → Build Project** (or press `Ctrl+F9`)
3. Wait for compilation to complete

**Option B: Using Command Line**
1. Run the build script:
   ```bash
   # Windows
   build.bat
   
   # Linux/Mac
   ./build.sh
   ```

#### Step 4: Deploy to Tomcat

**Option A: Using IntelliJ IDEA**
1. Go to **Run → Edit Configurations**
2. Click **+** and select **Tomcat Server → Local**
3. Set **Application Server** to your Tomcat installation
4. Set **URL** to `http://localhost:8080/PahanaEdu`
5. Click **Run**

**Option B: Manual Deployment**
1. Run the deploy script:
   ```bash
   # Windows
   deploy.bat
   
   # Linux/Mac
   ./deploy.sh
   ```
2. Start Tomcat server
3. Access the application at `http://localhost:8080/PahanaEdu`

#### Step 5: Access the Application

- **URL**: `http://localhost:8080/PahanaEdu/`
- **Default Login**:
  - Username: `admin`
  - Password: `admin123`

## 🏗️ Project Structure

```
PahanaEdu/
├── 📁 src/
│   └── 📁 com/pahanaedu/
│       ├── 📁 dao/          # Data Access Objects
│       ├── 📁 filters/      # Authentication filters
│       ├── 📁 model/        # Entity classes (User, Customer, Item, Bill)
│       ├── 📁 service/      # Business logic
│       ├── 📁 servlets/     # Web controllers
│       └── 📁 util/         # Utility classes
├── 📁 web/
│   ├── 📁 WEB-INF/
│   │   ├── 📁 lib/          # JAR dependencies
│   │   └── web.xml          # Web configuration
│   ├── 📁 billing/          # Billing pages
│   ├── 📁 customer/         # Customer management pages
│   ├── 📁 item/             # Item management pages
│   ├── dashboard.jsp        # Main dashboard
│   ├── help.jsp             # Help page
│   └── login.jsp            # Login page
├── 📁 logs/                 # Application logs
├── 📁 conf/                 # Configuration files
├── build.bat               # Build script
├── deploy.bat              # Deployment script
└── README.md               # This file
```

## 🎮 How to Use

### 1. **Login to the System**
- Open your browser and go to `http://localhost:8080/PahanaEdu/`
- Enter username: `admin` and password: `admin123`
- Click "Login"

### 2. **Manage Customers**
- Click "Customers" in the sidebar
- **Add Customer**: Click "Add New Customer" button
- **Edit Customer**: Click "Edit" button next to any customer
- **Delete Customer**: Click "Delete" button (with confirmation)

### 3. **Manage Items**
- Click "Items" in the sidebar
- **Add Item**: Click "Add New Item" button
- **Edit Item**: Click "Edit" button next to any item
- **Delete Item**: Click "Delete" button (with confirmation)

### 4. **Create Bills**
- Click "Create Bill" from the dashboard
- Select a customer from the dropdown
- Add items with quantities
- Click "Create Bill" to generate the invoice

### 5. **Logout**
- Click the "Logout" button in the top-right corner
- You'll be redirected to the login page

## 🔧 Troubleshooting

### Common Issues and Solutions

#### ❌ **404 Error on Login**
**Problem**: Page not found when accessing the application
**Solution**:
- Ensure Tomcat is running
- Check that the application is deployed with context path `/PahanaEdu`
- Verify all JSP files are in the correct location

#### ❌ **Database Connection Error**
**Problem**: Cannot connect to PostgreSQL
**Solution**:
- Verify PostgreSQL service is running
- Check database credentials in `DatabaseConnection.java`
- Ensure database `pahanaedu_bookshop` exists
- Run the database setup script

#### ❌ **Servlet Mapping Errors**
**Problem**: Servlets not responding
**Solution**:
- Check that all servlets have `@WebServlet` annotations
- Verify URL patterns match between servlets and JSP forms
- Rebuild the project to compile servlets

#### ❌ **Build Errors**
**Problem**: Compilation fails
**Solution**:
- Ensure all required JAR files are in `web/WEB-INF/lib/`
- Check Java version compatibility (Java 11+)
- Clean and rebuild the project

#### ❌ **Logout Not Working**
**Problem**: Logout button doesn't work
**Solution**:
- Ensure `LogoutServlet.class` is compiled
- Check that `LoginServlet` has both `doGet()` and `doPost()` methods
- Rebuild the project

### Required Dependencies

Make sure these JAR files are in `web/WEB-INF/lib/`:
- `javax.servlet-api-4.0.1.jar`
- `postgresql-42.7.3.jar`
- `jstl-1.2.jar`

## 🛠️ Development

### Adding New Features

1. **Create Model Classes** in `src/com/pahanaedu/model/`
2. **Create DAO Interfaces** in `src/com/pahanaedu/dao/`
3. **Create Servlets** in `src/com/pahanaedu/servlets/`
4. **Create JSP Pages** in `web/`
5. **Update web.xml** if needed

### Code Style Guidelines

- Follow Java naming conventions
- Use meaningful variable and method names
- Add comments for complex logic
- Handle exceptions appropriately
- Use proper indentation and formatting

### Building and Deploying

```bash
# Build the project
build.bat

# Deploy to Tomcat
deploy.bat

# Or use IntelliJ IDEA
# Build → Build Project
# Run → Run 'Tomcat Server'
```

## 📞 Support

If you encounter any issues:

1. **Check the logs** in the `logs/` directory
2. **Verify all prerequisites** are installed correctly
3. **Ensure database** is properly configured
4. **Rebuild the project** if servlets aren't working

## 📄 License

This project is developed for educational purposes. Feel free to use, modify, and distribute as needed.

## 🙏 Acknowledgments

- **Bootstrap** for the responsive UI framework
- **Font Awesome** for the beautiful icons
- **PostgreSQL** for the reliable database
- **Apache Tomcat** for the web server

---

**Happy Bookshop Management! 📚✨**