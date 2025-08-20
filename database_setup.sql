-- Database setup script for PahanaEdu Bookshop
-- Run this script in your PostgreSQL database

-- Create database (if not exists)
-- CREATE DATABASE pahanaedu_bookshop;

-- Connect to the database
-- \c pahanaedu_bookshop;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    role VARCHAR(20) DEFAULT 'user'
);

-- Create customers table
CREATE TABLE IF NOT EXISTS customers (
    account_number VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    telephone VARCHAR(20)
);

-- Create items table
CREATE TABLE IF NOT EXISTS items (
    item_code VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INTEGER DEFAULT 0,
    category VARCHAR(50)
);

-- Create bills table
CREATE TABLE IF NOT EXISTS bills (
    bill_id SERIAL PRIMARY KEY,
    bill_number VARCHAR(20) UNIQUE NOT NULL,
    customer_account_number VARCHAR(20) REFERENCES customers(account_number),
    bill_date DATE DEFAULT CURRENT_DATE,
    total_amount DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'pending'
);

-- Create bill_items table
CREATE TABLE IF NOT EXISTS bill_items (
    bill_item_id SERIAL PRIMARY KEY,
    bill_id INTEGER REFERENCES bills(bill_id),
    item_code VARCHAR(20) REFERENCES items(item_code),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL
);

-- Insert sample data

-- Insert sample user
INSERT INTO users (username, password_hash, full_name, email, role) 
VALUES ('admin', 'admin123', 'Administrator', 'admin@pahanaedu.com', 'admin')
ON CONFLICT (username) DO NOTHING;

-- Insert sample customers
INSERT INTO customers (account_number, name, address, telephone) VALUES
('CUST001', 'John Doe', '123 Main St, City', '+1234567890'),
('CUST002', 'Jane Smith', '456 Oak Ave, Town', '+0987654321')
ON CONFLICT (account_number) DO NOTHING;

-- Insert sample items
INSERT INTO items (item_code, name, description, price, stock, category) VALUES
('ITEM001', 'Java Programming Book', 'Complete guide to Java programming', 29.99, 50, 'Books'),
('ITEM002', 'Python Basics', 'Introduction to Python programming', 24.99, 30, 'Books'),
('ITEM003', 'Web Development Guide', 'HTML, CSS, and JavaScript guide', 34.99, 25, 'Books')
ON CONFLICT (item_code) DO NOTHING; 