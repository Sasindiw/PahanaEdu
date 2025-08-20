# Billing System - PahanaEdu Bookshop

## Overview
The billing system allows users to create bills for customers, calculate amounts based on units consumed, and print bills. The system integrates with the existing customer and item management functionality.

## Features

### 1. Create Bill
- Select customer from existing customer list
- Add multiple items to the bill
- Dynamic calculation of totals based on quantity and unit price
- Real-time validation of stock availability
- Automatic bill number generation

### 2. Calculate and Print Bill
- Automatic calculation of bill amounts based on units consumed
- Print-friendly bill format
- Professional bill layout with company branding
- Option to print directly or save as PDF

### 3. Bill Management
- Store bills in database with proper relationships
- Track bill status (pending, paid, etc.)
- Maintain audit trail with creation timestamps
- Link bills to customers and items

## Database Schema

### Bills Table
```sql
CREATE TABLE public.bills (
    bill_id serial4 NOT NULL,
    bill_number varchar(20) NOT NULL,
    customer_account_number varchar(50) NULL,
    bill_date date DEFAULT CURRENT_DATE NULL,
    total_amount numeric(10, 2) DEFAULT 0 NULL,
    status varchar(20) DEFAULT 'pending'::character varying NULL,
    created_by varchar(50) NULL,
    created_date timestamp DEFAULT CURRENT_TIMESTAMP NULL,
    CONSTRAINT bills_bill_number_key UNIQUE (bill_number),
    CONSTRAINT bills_pkey PRIMARY KEY (bill_id)
);
```

### Bill Items Table
```sql
CREATE TABLE public.bill_items (
    bill_item_id serial4 NOT NULL,
    bill_id int4 NULL,
    item_code varchar(50) NULL,
    quantity int4 NOT NULL,
    unit_price numeric(10, 2) NOT NULL,
    total_price numeric(10, 2) NOT NULL,
    CONSTRAINT bill_items_pkey PRIMARY KEY (bill_item_id)
);
```

## Files Structure

### Model Classes
- `src/com/pahanaedu/model/Bill.java` - Bill entity
- `src/com/pahanaedu/model/BillItem.java` - Bill item entity

### DAO Classes
- `src/com/pahanaedu/dao/BillDAO.java` - Bill data access interface
- `src/com/pahanaedu/dao/BillDAOImpl.java` - Bill data access implementation
- `src/com/pahanaedu/dao/BillItemDAO.java` - Bill item data access interface
- `src/com/pahanaedu/dao/BillItemDAOImpl.java` - Bill item data access implementation

### Servlets
- `src/com/pahanaedu/servlets/PrintBillServlet.java` - Handles bill printing

### JSP Pages
- `web/billing/print.jsp` - Bill print view

### Database
- `create_billing_tables.sql` - Database schema creation script

## Usage

### 1. Accessing the Billing System
- Navigate to Dashboard

### 2. Creating a Bill
- This feature has been removed.

### 3. Printing a Bill
- Navigate to an existing bill's print view.

## Key Features

### Dynamic Item Addition
- Add unlimited items to a bill
- Remove items individually
- Real-time calculation updates

### Stock Validation
- Quantity cannot exceed available stock
- Automatic adjustment to maximum available stock

### Bill Number Generation
- Automatic generation of unique bill numbers
- Format: BILL + YYYYMMDD + sequential number
- Example: BILL20241201001

### Print Functionality
- Professional bill layout
- Company branding and logo
- Print-optimized CSS
- Option to hide action buttons when printing

## Technical Implementation

### JavaScript Features
- ES5 compatible for broad browser support
- Dynamic form manipulation
- Real-time calculations
- Form validation
- Print functionality

### CSS Features
- Responsive design
- Print-optimized styles
- Consistent with existing application theme
- Professional appearance

### Security Features
- Session-based authentication
- Input validation
- SQL injection prevention through prepared statements
- XSS prevention through proper output encoding

## Dependencies
- Bootstrap 5.1.3
- Font Awesome 6.0.0
- JSTL (JSP Standard Tag Library)
- PostgreSQL JDBC Driver

## Setup Instructions

1. **Database Setup**
   ```sql
   -- Run the create_billing_tables.sql script
   psql -d your_database -f create_billing_tables.sql
   ```

2. **Deploy Application**
   - Copy all files to your Tomcat webapps directory
   - Ensure all dependencies are in WEB-INF/lib
   - Restart Tomcat

3. **Access the Application**
   - Navigate to your application URL
   - Login with valid credentials
   - Access billing through dashboard

## Troubleshooting

### Common Issues
1. **Compilation Errors**: Ensure all servlet API dependencies are in classpath
2. **Database Connection**: Verify database connection settings in DatabaseConnection.java
3. **Print Issues**: Check browser print settings and ensure JavaScript is enabled

### Error Messages
- "Customer is required" - Select a customer before creating bill
- "At least one item is required" - Add at least one item to the bill
- "Invalid bill ID" - Bill not found or invalid ID format

## Future Enhancements
- Bill status management (pending, paid, cancelled)
- Bill history and search functionality
- Email bill functionality
- Payment integration
- Advanced reporting and analytics
