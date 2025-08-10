CREATE TABLE ecommerce_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    product_name VARCHAR(100),
    category VARCHAR(50),
    quantity INT CHECK (quantity > 0),
    price NUMERIC(10, 2) CHECK (price >= 0),
    order_date DATE,
    payment_method VARCHAR(50),
    status VARCHAR(20)
);

INSERT INTO ecommerce_orders
(order_id, customer_name, product_name, category, quantity, price, order_date, payment_method, status)
VALUES
(1, 'Ravi Kumar', 'Smartphone', 'Electronics', 1, 15000.00, '2025-08-01', 'UPI', 'Delivered'),
(2, 'Anita Sharma', 'T-Shirt', 'Fashion', 2, 800.00, '2025-08-02', 'Credit Card', 'Delivered'),
(3, 'Suresh Gupta', 'Laptop', 'Electronics', 1, 55000.00, '2025-08-02', 'Net Banking', 'Pending'),
(4, 'Neha Patel', 'Mixer Grinder', 'Home Appliances', 1, 3500.00, '2025-08-03', 'Debit Card', 'Delivered'),
(5, 'Amit Verma', 'Shoes', 'Fashion', 1, 2000.00, '2025-08-04', 'Cash on Delivery', 'Cancelled');

SELECT * FROM ecommerce_orders;

CREATE OR REPLACE FUNCTION generate_ecom_report()
RETURNS void AS $$
DECLARE
    rec RECORD;
    total_qty INT := 0;
    total_sales NUMERIC(15,2) := 0;
BEGIN
    FOR rec IN 
        SELECT category, quantity, price
        FROM ecommerce_orders
        WHERE status = 'Delivered'
    LOOP
        RAISE NOTICE 'Category: %, Quantity: %, Price: %', rec.category, rec.quantity, rec.price;
        total_qty := total_qty + rec.quantity;
        total_sales := total_sales + (rec.quantity * rec.price);
    END LOOP;

    RAISE NOTICE 'Total Items Sold: %, Total Revenue: %', total_qty, total_sales;
END;
$$ LANGUAGE plpgsql;

SELECT generate_ecom_report();