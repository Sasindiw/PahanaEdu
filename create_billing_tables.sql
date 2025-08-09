-- Create billing tables for PahanaEdu Bookshop
-- This script creates the bills and bill_items tables

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS public.bill_items CASCADE;
DROP TABLE IF EXISTS public.bills CASCADE;

-- Create bills table
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

-- Create bill_items table
CREATE TABLE public.bill_items (
    bill_item_id serial4 NOT NULL,
    bill_id int4 NULL,
    item_code varchar(50) NULL,
    quantity int4 NOT NULL,
    unit_price numeric(10, 2) NOT NULL,
    total_price numeric(10, 2) NOT NULL,
    CONSTRAINT bill_items_pkey PRIMARY KEY (bill_item_id)
);

-- Add foreign key constraints
ALTER TABLE public.bills ADD CONSTRAINT bills_customer_account_number_fkey 
    FOREIGN KEY (customer_account_number) REFERENCES public.customers(account_number);

ALTER TABLE public.bill_items ADD CONSTRAINT bill_items_bill_id_fkey 
    FOREIGN KEY (bill_id) REFERENCES public.bills(bill_id) ON DELETE CASCADE;

ALTER TABLE public.bill_items ADD CONSTRAINT bill_items_item_code_fkey 
    FOREIGN KEY (item_code) REFERENCES public.items(item_code);

-- Create indexes for better performance
CREATE INDEX idx_bills_customer_account_number ON public.bills(customer_account_number);
CREATE INDEX idx_bills_bill_date ON public.bills(bill_date);
CREATE INDEX idx_bills_status ON public.bills(status);
CREATE INDEX idx_bill_items_bill_id ON public.bill_items(bill_id);
CREATE INDEX idx_bill_items_item_code ON public.bill_items(item_code);

-- Insert sample data (optional)
-- INSERT INTO public.bills (bill_number, customer_account_number, bill_date, total_amount, status, created_by) 
-- VALUES ('BILL20241201001', 'ACC001', '2024-12-01', 1250.00, 'pending', 'admin');

-- INSERT INTO public.bill_items (bill_id, item_code, quantity, unit_price, total_price) 
-- VALUES (1, 'BOOK001', 2, 500.00, 1000.00), (1, 'BOOK002', 1, 250.00, 250.00);

COMMENT ON TABLE public.bills IS 'Stores bill information for the bookshop';
COMMENT ON TABLE public.bill_items IS 'Stores individual items within each bill';
