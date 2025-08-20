-- Fix database schema to match application expectations

-- 1. Update the users table to match application requirements
ALTER TABLE public.users 
    ALTER COLUMN email DROP NOT NULL,
    ALTER COLUMN role DROP DEFAULT,
    ALTER COLUMN role TYPE varchar(20),
    DROP CONSTRAINT users_role_check;

-- 2. Insert the admin user with correct role format
INSERT INTO public.users (username, password_hash, full_name, email, role) 
VALUES ('admin', 'Admin123', 'Administrator', 'admin@pahanaedu.com', 'admin')
ON CONFLICT (username) DO UPDATE SET 
    password_hash = 'Admin123',
    full_name = 'Administrator',
    email = 'admin@pahanaedu.com',
    role = 'admin';

-- 3. Insert sample customers
INSERT INTO public.customers (account_number, name, address, telephone) VALUES
('CUST001', 'John Doe', '123 Main St, City', '+1234567890'),
('CUST002', 'Jane Smith', '456 Oak Ave, Town', '+0987654321')
ON CONFLICT (account_number) DO NOTHING;

-- 4. Insert sample items
INSERT INTO public.items (item_code, name, description, price, stock, category) VALUES
('ITEM001', 'Java Programming Book', 'Complete guide to Java programming', 29.99, 50, 'Books'),
('ITEM002', 'Python Basics', 'Introduction to Python programming', 24.99, 30, 'Books'),
('ITEM003', 'Web Development Guide', 'HTML, CSS, and JavaScript guide', 34.99, 25, 'Books')
ON CONFLICT (item_code) DO NOTHING;

-- 5. Verify the setup
SELECT 'Database fixed successfully!' as status;
SELECT COUNT(*) as user_count FROM users;
SELECT username, role FROM users WHERE username = 'admin'; 