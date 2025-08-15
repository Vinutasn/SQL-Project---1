-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database
\c OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


--BASIC QUERIES

--Retrieve all books in the "Fiction" genre
SELECT * from Books
WHERE genre='Fiction';

--Find books published after the year 1950
SELECT * FROM Books
WHERE published_year>1950;

--List all customers from the Canada
SELECT * FROM Customers
WHERE country='Canada';

--Show orders placed in November 2023
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--Retrieve the total stock of books available
SELECT SUM(stock) AS Total_stock FROM Books;

--Find the details of the most expensive book
SELECT * FROM Books
WHERE price IN (SELECT MAX(price) FROM Books);

--OR
SELECT * FROM Books 
ORDER BY price DESC
LIMIT 1;

--Show all customers who ordered more than 1 quantity of a book
SELECT * FROM Orders
WHERE quantity>1;

--Retrieve all orders where the total amount exceeds $20
SELECT * FROM orders
WHERE total_amount>20;

-- List all genres available in the Books table
SELECT DISTINCT genre FROM Books;

-- Find the book with the lowest stock
SELECT * FROM Books
ORDER BY stock
LIMIT 1;

--Calculate the total revenue generated from all orders
SELECT SUM(total_amount) AS Revenue FROM Orders;

/*
ADVANCE QUERIES

--Retrieve the total number of books sold for each genre
SELECT * FROM Books;
SELECT * FROM Orders;

SELECT b.genre, SUM(o.quantity) AS Total_Books_Sold
FROM Books b
JOIN 
Orders o ON (b.book_id=o.book_id)
GROUP BY b.genre;

-- Find the average price of books in the "Fantasy" genre
SELECT AVG(price) AS Avg_Price FROM Books
WHERE genre='Fantasy';

--List customers who have placed at least 2 orders
SELECT * FROM Customers
SELECT * FROM Orders

SELECT customer_id, COUNT(order_id) AS Total_Orders
FROM Orders
GROUP BY customer_id
HAVING COUNT(order_id)>=2;

--Find the most frequently ordered book
SELECT book_id, COUNT(order_id) AS Frequently_ordered
FROM Orders
GROUP BY book_id
ORDER BY COUNT(order_id) DESC
LIMIT 1;

--Show the top 3 most expensive books of 'Fantasy' Genre
SELECT * FROM Books
WHERE genre='Fantasy'
ORDER BY price DESC
LIMIT 3;

-- Retrieve the total quantity of books sold by each author
SELECT * FROM Books
SELECT * FROM Orders

SELECT b.author, SUM(o.quantity) AS Total_quantity_of_books
FROM Books b
JOIN Orders o ON (b.book_id=o.book_id)
GROUP BY b.author;

--List the cities where customers who spent over $30 are located
SELECT * FROM Customers
SELECT * FROM Orders

SELECT DISTINCT c.city, o.total_amount, c.name
FROM Customers c
JOIN 
Orders o ON (c.customer_id=o.customer_id)
WHERE o.total_amount>30;

--Find the customer who spent the most on orders
SELECT * FROM Customers
SELECT * FROM Orders

SELECT c.customer_id, c.name, SUM(o.total_amount) AS most_spent
FROM Customers c
JOIN Orders o ON (c.customer_id=o.customer_id)
GROUP BY c.customer_id, c.name
ORDER BY most_spent DESC
LIMIT 1;

--Calculate the stock remaining after fulfilling all orders
SELECT * FROM Books
SELECT * FROM Orders

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity, b.stock-COALESCE(SUM(o.quantity),0) AS 
Remaining_stock
FROM Books b
LEFT JOIN Orders o ON (b.book_id=o.book_id)
GROUP BY b.book_id;
*/

--Retrieve the total number of books sold for each genre
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM books;

SELECT b.genre, SUM(o.quantity) AS total_books
FROM books b
JOIN orders o ON (b.book_id=o.book_id)
GROUP BY b.genre;

-- Find the average price of books in the "Fantasy" genre
SELECT AVG(price) FROM books
WHERE genre='Fantasy';

--List customers who have placed at least 2 orders
SELECT customer_id, COUNT(order_id) AS order_count FROM orders
GROUP BY customer_id
HAVING COUNT(order_id)>=2
ORDER BY customer_id;

--Find the most frequently ordered book
SELECT book_id, COUNT(order_id) AS Frequently_ordered
FROM Orders
GROUP BY book_id
ORDER BY COUNT(order_id) DESC
LIMIT 1;


