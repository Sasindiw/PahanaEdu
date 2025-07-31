-- Create billing tables for PahanaEdu Bookshop

-- Create bills table
CREATE TABLE IF NOT EXISTS bills (
    bill_id SERIAL PRIMARY KEY,
    bill_number VARCHAR(20) UNIQUE NOT NULL,
    customer_account_number VARCHAR(50) REFERENCES customers(account_number),
    bill_date DATE DEFAULT CURRENT_DATE,
    total_amount DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'pending',
    created_by VARCHAR(50),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create bill_items table
CREATE TABLE IF NOT EXISTS bill_items (
    bill_item_id SERIAL PRIMARY KEY,
    bill_id INTEGER REFERENCES bills(bill_id) ON DELETE CASCADE,
    item_code VARCHAR(50) REFERENCES items(item_code),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL
);

-- Create sequence for bill numbers
CREATE SEQUENCE IF NOT EXISTS bill_number_seq START 1001;

-- Insert sample data for testing
INSERT INTO bills (bill_number, customer_account_number, total_amount, status, created_by) VALUES
('BILL-1001', 'CUST001', 59.98, 'completed', 'admin'),
('BILL-1002', 'CUST002', 34.99, 'pending', 'admin')
ON CONFLICT (bill_number) DO NOTHING;

INSERT INTO bill_items (bill_id, item_code, quantity, unit_price, total_price) VALUES
(1, 'ITEM001', 2, 29.99, 59.98),
(2, 'ITEM003', 1, 34.99, 34.99)
ON CONFLICT DO NOTHING; 