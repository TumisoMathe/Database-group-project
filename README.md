# Bookstore Database Project

## Overview

This project involves designing and implementing a MySQL database for a bookstore. The database will store and manage information related to the bookstore's operations, including books, authors, customers, orders, and shipping.

## Tools and Technologies

* **MySQL:** For building and managing the relational database.

## Prerequisites

To successfully complete this project, we should have a comfortable understanding of the following:

* Basics of MySQL.
* Creating tables in MySQL with appropriate data types.
* Managing MySQL users and applying security best practices.

## Database Design

The database will consist of the following tables:

* `book`: Stores information about books.
* `book_author`: Manages the many-to-many relationship between books and authors.
* `author`: Stores information about authors.
* `book_language`: Stores a list of possible languages for books.
* `publisher`: Stores information about publishers.
* `Customer`: Stores information about the bookstore's customers.
* `customer_address`: Stores addresses for customers (each customer can have multiple addresses).
* `address_status`: Stores statuses for addresses (e.g., current, old).
* `address`: Stores address details.
* `country`: Stores a list of countries.
* `cust_order`: Stores information about customer orders.
* `order_line`: Stores information about the books included in each order.
* `shipping_method`: Stores possible shipping methods[cite: 16].
* `order_history`: Stores the history of orders (e.g., ordered, cancelled, delivered).
* `order_status`: Stores possible statuses for orders[cite: 18].

## Implementation Steps

1.  **Create Database:** Create a new MySQL database to store the bookstore data.
2.  **Design Schema:** Determine the table schemas and appropriate data types for each column.  It is recommended to use Draw.io to visualize the database schema.
3.  **Create Tables:** Write SQL `CREATE TABLE` statements to create the tables defined in the database design[cite: 7].
4.  **User Management:** Set up user groups and roles to control access to the database and ensure security
5.  **Testing:** Test the database by running SQL queries to retrieve and analyze the data.