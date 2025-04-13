-- Create database
CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;

CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    language_id INT,
    publisher_id INT,
    publication_date DATE,
    price DECIMAL(10, 2),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

INSERT INTO book (title, isbn, language_id, publisher_id, publication_date, price) VALUES
('The Great Gatsby', '978-0743273565', 1, 1, '1925-04-10', 12.99),
('To Kill a Mockingbird', '978-0061120084', 1, 2, '1960-07-11', 10.99),
('1984', '978-0451524935', 1, 3, '1949-06-08', 9.99),
('Pride and Prejudice', '978-0141439518', 1, 4, '1813-01-28', 8.99),
('One Hundred Years of Solitude', '978-0060883286', 2, 5, '1967-05-30', 14.99);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    biography TEXT
);

INSERT INTO author (first_name, last_name, biography) VALUES
('F. Scott', 'Fitzgerald', 'An American novelist and short story writer.'),
('Harper', 'Lee', 'An American novelist widely known for To Kill a Mockingbird.'),
('George', 'Orwell', 'An English novelist, essayist, journalist, and critic.'),
('Jane', 'Austen', 'An English novelist known primarily for her six novels...'),
('Gabriel', 'Garcia Marquez', 'A Colombian novelist, short-story writer, screenwriter and journalist...');

CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO book_language (language_name) VALUES
('English'),
('Spanish');

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100)
);

INSERT INTO publisher (publisher_name, city, country) VALUES
('Scribner', 'New York', 'USA'),
('J. B. Lippincott & Co.', 'Philadelphia', 'USA'),
('Secker & Warburg', 'London', 'UK'),
('T. Egerton', 'London', 'UK'),
('Harper & Row', 'New York', 'USA');

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20)
);

INSERT INTO Customer (first_name, last_name, email, phone_number) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678'),
('David', 'Lee', 'david.lee@example.com', '555-9012');

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    address_status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);

INSERT INTO customer_address (customer_id, address_id, address_status_id) VALUES
(1, 1, 1),  -- John Doe, 123 Main St, Current
(2, 2, 1),  -- Jane Smith, 456 Oak Ave, Current
(2, 3, 2),  -- Jane Smith, 789 Pine Lane, Old
(3, 4, 1);  -- David Lee, 10 Downing St, Current

CREATE TABLE address_status (
    address_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO address_status (status_name) VALUES
('Current'),
('Old');

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

INSERT INTO address (address_line1, address_line2, city, country_id) VALUES
('123 Main Street', '', 'Anytown', 1),
('456 Oak Avenue', 'Apt 2B', 'Springfield', 1),
('789 Pine Lane', '', 'Suburbia', 1),
('10 Downing Street', '', 'London', 2),
('5th Avenue', 'Suite 200', 'New York', 1);

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO country (country_name) VALUES
('USA'),
('UK');

CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    shipping_address_id INT,
    order_status_id INT,
    shipping_method_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id)
);

INSERT INTO cust_order (customer_id, order_date, shipping_address_id, order_status_id, shipping_method_id) VALUES
(1, '2024-03-01', 1, 1, 1),
(2, '2024-03-05', 2, 2, 2),
(3, '2024-03-10', 4, 3, 1);

CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 1, 12.99),
(1, 3, 2, 9.99),
(2, 2, 1, 10.99),
(3, 5, 1, 14.99);

CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    cost DECIMAL(10, 2)
);

INSERT INTO shipping_method (method_name, cost) VALUES
('Standard', 5.99),
('Express', 9.99);

CREATE TABLE order_history (
    order_history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    order_status_id INT,
    status_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

INSERT INTO order_history (order_id, order_status_id, status_date) VALUES
(1, 1, '2024-03-01 10:00:00'), -- Order 1, Pending
(1, 2, '2024-03-02 14:30:00'), -- Order 1, Shipped
(2, 2, '2024-03-05 12:00:00'), -- Order 2, Shipped
(3, 3, '2024-03-10 09:00:00'); -- Order 3, Delivered

CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO order_status (status_name) VALUES
('Pending'),
('Shipped'),
('Delivered');

-- User and Role Management
CREATE USER 'tumiso'@'localhost' IDENTIFIED BY 'app123';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore_db.* TO 'tumiso'@'localhost';

CREATE USER 'chungu'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'tumiso'@'localhost';

CREATE ROLE 'sharon';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.cust_order TO 'sharon';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.order_line TO 'sharon';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.order_history TO 'sharon';
GRANT SELECT ON bookstore_db.Customer TO 'sharon';
GRANT SELECT ON bookstore_db.address TO 'sharon';
GRANT SELECT ON bookstore_db.shipping_method TO 'sharon';
GRANT SELECT ON bookstore_db.order_status TO 'sharon';
GRANT 'sharon' TO 'tumiso'@'localhost';
