-- Check existing customers in the database
SELECT * FROM customers;

-- Insert sample customers if the table is empty
INSERT INTO customers (account_number, name, address, telephone) VALUES
('CUST001', 'John Doe', '123 Main Street, Colombo', '+94 11 234 5678'),
('CUST002', 'Jane Smith', '456 Oak Avenue, Kandy', '+94 81 345 6789'),
('CUST003', 'Bob Johnson', '789 Pine Road, Galle', '+94 91 456 7890'),
('CUST004', 'Alice Brown', '321 Elm Street, Jaffna', '+94 21 567 8901'),
('CUST005', 'Charlie Wilson', '654 Maple Drive, Anuradhapura', '+94 25 678 9012')
ON CONFLICT (account_number) DO NOTHING;

-- Check items table for sample data
SELECT * FROM items;

-- Insert sample items if the table is empty
INSERT INTO items (item_code, name, description, price, stock, category) VALUES
('ITEM001', 'A/L Physics Book', 'Advanced Level Physics Textbook', 29.99, 50, 'Books'),
('ITEM002', 'A/L Mathematics Book', 'Advanced Level Mathematics Textbook', 34.99, 45, 'Books'),
('ITEM003', 'A/L Chemistry Book', 'Advanced Level Chemistry Textbook', 32.99, 40, 'Books'),
('ITEM004', 'A/L Biology Book', 'Advanced Level Biology Textbook', 31.99, 35, 'Books'),
('ITEM005', 'O/L Science Book', 'Ordinary Level Science Textbook', 25.99, 60, 'Books'),
('ITEM006', 'O/L Mathematics Book', 'Ordinary Level Mathematics Textbook', 23.99, 55, 'Books'),
('ITEM007', 'English Dictionary', 'Comprehensive English Dictionary', 19.99, 30, 'Reference'),
('ITEM008', 'Scientific Calculator', 'Casio Scientific Calculator', 15.99, 25, 'Electronics'),
('ITEM009', 'Notebook Set', 'Set of 5 A4 Notebooks', 12.99, 100, 'Stationery'),
('ITEM010', 'Pen Set', 'Set of 10 Blue Pens', 8.99, 150, 'Stationery')
ON CONFLICT (item_code) DO NOTHING; 