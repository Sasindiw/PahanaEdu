# PahanaEdu Bookshop Management System

A Java web application for managing a bookshop with customer, item, and billing management features.

## Features

- User authentication and authorization
- Customer management (add, edit, delete, list)
- Item management (add, edit, delete, list)
- Billing system
- Responsive web interface

## Prerequisites

- Java 11 or higher
- Apache Tomcat 9.0 or higher
- PostgreSQL 12 or higher
- IntelliJ IDEA (recommended)

## Setup Instructions

### 1. Database Setup

1. Create a PostgreSQL database named `pahanaedu_bookshop`
2. Run the `database_setup.sql` script to create tables and sample data:
   ```sql
   psql -U postgres -d pahanaedu_bookshop -f database_setup.sql
   ```

### 2. Database Configuration

Update the database connection settings in `src/com/pahanaedu/util/DatabaseConnection.java`:
- URL: `jdbc:postgresql://localhost:5432/pahanaedu_bookshop`
- Username: `postgres`
- Password: `123456` (change as needed)

### 3. Project Setup

1. Clone or download the project
2. Open the project in IntelliJ IDEA
3. Configure the project SDK to Java 11 or higher
4. Build the project (Build → Build Project)

### 4. Tomcat Configuration

1. Configure Tomcat in IntelliJ IDEA:
   - Go to Run → Edit Configurations
   - Add new Tomcat Server → Local
   - Set Application Server to your Tomcat installation
   - Set URL to `http://localhost:8080/PahanaEdu`

2. Deploy the application:
   - Build the artifact (Build → Build Artifacts → PahanaEdu → Build)
   - Deploy to Tomcat

### 5. Access the Application

- URL: `http://localhost:8080/PahanaEdu/`
- Default login credentials:
  - Username: `admin`
  - Password: `admin123`

## Project Structure

```
src/
├── com/pahanaedu/
│   ├── dao/           # Data Access Objects
│   ├── model/         # Entity classes
│   ├── service/       # Business logic
│   ├── servlets/      # Web controllers
│   └── util/          # Utility classes
web/
├── WEB-INF/
│   ├── lib/           # JAR dependencies
│   └── web.xml        # Web configuration
├── customer/          # Customer management pages
├── item/              # Item management pages
├── dashboard.jsp      # Main dashboard
└── login.jsp          # Login page
```

## Troubleshooting

### Common Issues

1. **404 Error on Login**
   - Ensure Tomcat is running
   - Check that the application is deployed with context path `/PahanaEdu`
   - Verify JSP files are in the correct location

2. **Database Connection Error**
   - Verify PostgreSQL is running
   - Check database credentials in `DatabaseConnection.java`
   - Ensure database and tables exist

3. **Servlet Mapping Errors**
   - Check that all servlets have `@WebServlet` annotations
   - Verify URL patterns match between servlets and JSP forms

4. **Build Errors**
   - Ensure all required JAR files are in `web/WEB-INF/lib/`
   - Check Java version compatibility
   - Clean and rebuild the project

### Required JAR Files

- `javax.servlet-api-4.0.1.jar`
- `postgresql-42.7.3.jar`

## Development

### Adding New Features

1. Create model classes in `src/com/pahanaedu/model/`
2. Create DAO interfaces and implementations in `src/com/pahanaedu/dao/`
3. Create servlets in `src/com/pahanaedu/servlets/`
4. Create JSP pages in `web/`
5. Update `web.xml` if needed

### Code Style

- Follow Java naming conventions
- Use meaningful variable and method names
- Add comments for complex logic
- Handle exceptions appropriately

## License

This project is for educational purposes.