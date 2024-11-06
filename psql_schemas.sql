-- Drop and create the 'olist_products_dataset' table
DROP TABLE IF EXISTS olist_products_dataset CASCADE;
CREATE TABLE olist_products_dataset (
   product_id VARCHAR(32) PRIMARY KEY,
   product_category_name VARCHAR(64),
   product_name_length INT,
   product_description_length INT,
   product_photos_qty INT,
   product_weight_g INT,
   product_length_cm INT,
   product_height_cm INT,
   product_width_cm INT
);

-- Drop and create the 'olist_orders_dataset' table
DROP TABLE IF EXISTS olist_orders_dataset CASCADE;
CREATE TABLE olist_orders_dataset (
   order_id VARCHAR(32) PRIMARY KEY,
   customer_id VARCHAR(32),
   order_status VARCHAR(16),
   order_purchase_timestamp TIMESTAMP,
   order_approved_at TIMESTAMP,
   order_delivered_carrier_date TIMESTAMP,
   order_delivered_customer_date TIMESTAMP,
   order_estimated_delivery_date TIMESTAMP
);

-- Drop and create the 'olist_order_items_dataset' table
DROP TABLE IF EXISTS olist_order_items_dataset CASCADE;
CREATE TABLE olist_order_items_dataset (
   order_id VARCHAR(32),
   order_item_id INT,
   product_id VARCHAR(32),
   seller_id VARCHAR(32),
   shipping_limit_date TIMESTAMP,
   price FLOAT,
   freight_value FLOAT,
   PRIMARY KEY (order_id, order_item_id)
);

-- Drop and create the 'olist_order_payments_dataset' table
DROP TABLE IF EXISTS olist_order_payments_dataset CASCADE;
CREATE TABLE olist_order_payments_dataset (
   order_id VARCHAR(32),
   payment_sequential INT,
   payment_type VARCHAR(16),
   payment_installments INT,
   payment_value FLOAT,
   PRIMARY KEY (order_id, payment_sequential)
);