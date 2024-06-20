# Online Bookstore Database Project

### Group Number: 04

### Roles and responsibilities of Team Member
### Group Team Details.
##### 1) Shivani Varu (8941914): TypeScript Interface Development and Containerized Project with Docker.
##### 2) Sunil Patel (8984798):Database Schema Design.
##### 3) Vraj Soni   (8969071):Sample Data Creation(DDL,DML.CRUD).
##### 4) Jenish bhalala (8998191):SQL Queries Implementation.
##### 5) Aman Nijhawan(8897412): Readme File Creation.


## Database Design

## Database Tables and Data Types

### Authors Table

| Column     | Data Type         | Constraints                |
|------------|-------------------|----------------------------|
| author_id  | SERIAL            | PRIMARY KEY                |
| name       | VARCHAR(100)      | NOT NULL                   |
| biography  | TEXT              |                            |

### Publishers Table

| Column        | Data Type         | Constraints                |
|---------------|-------------------|----------------------------|
| publisher_id  | SERIAL            | PRIMARY KEY                |
| name          | VARCHAR(100)      | NOT NULL                   |
| address       | VARCHAR(200)      |                            |

### Books Table

| Column            | Data Type         | Constraints                                    |
|-------------------|-------------------|------------------------------------------------|
| book_id           | SERIAL            | PRIMARY KEY                                    |
| title             | VARCHAR(200)      | NOT NULL                                       |
| genre             | VARCHAR(50)       | NOT NULL                                       |
| author_id         | INT               | NOT NULL, FOREIGN KEY (author_id) REFERENCES Authors(author_id)     |
| publisher_id      | INT               | NOT NULL, FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id) |
| publication_date  | DATE              | NOT NULL                                       |
| price             | DECIMAL(10, 2)    | NOT NULL                                       |
| rating            | DECIMAL(3, 2)     |                                                |
| format            | VARCHAR(20)       | NOT NULL, CHECK (format IN ('physical', 'ebook', 'audiobook')) |

### Customers Table

| Column        | Data Type         | Constraints                |
|---------------|-------------------|----------------------------|
| customer_id   | SERIAL            | PRIMARY KEY                |
| name          | VARCHAR(100)      | NOT NULL                   |
| email         | VARCHAR(100)      | NOT NULL, UNIQUE           |
| total_spent   | DECIMAL(10, 2)    | NOT NULL                   |

### Orders Table

| Column        | Data Type         | Constraints                |
|---------------|-------------------|----------------------------|
| order_id      | SERIAL            | PRIMARY KEY                |
| customer_id   | INT               | NOT NULL, FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) |
| order_date    | DATE              | NOT NULL                   |
| total_amount  | DECIMAL(10, 2)    | NOT NULL                   |

### Order_Items Table

| Column          | Data Type         | Constraints                |
|-----------------|-------------------|----------------------------|
| order_item_id   | SERIAL            | PRIMARY KEY                |
| order_id        | INT               | NOT NULL, FOREIGN KEY (order_id) REFERENCES Orders(order_id)   |
| book_id         | INT               | NOT NULL, FOREIGN KEY (book_id) REFERENCES Books(book_id)     |
| quantity        | INT               | NOT NULL                   |

### Reviews Table

| Column        | Data Type         | Constraints                |
|---------------|-------------------|----------------------------|
| review_id     | SERIAL            | PRIMARY KEY                |
| customer_id   | INT               | NOT NULL, FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) |
| book_id       | INT               | NOT NULL, FOREIGN KEY (book_id) REFERENCES Books(book_id) |
| rating        | INT               | NOT NULL, CHECK (rating BETWEEN 1 AND 5) |
| comment       | TEXT              |                            |
| review_date   | DATE              | NOT NULL                   |


## SQL Code Block

```sql

-- Create Books Table
```CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    author_id INT NOT NULL,
    publisher_id INT NOT NULL,
    publication_date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    rating DECIMAL(3, 2),
    format VARCHAR(20) NOT NULL CHECK (format IN ('physical', 'ebook', 'audiobook')),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);```

-- Insert Sample Data into Books Table
```INSERT INTO Books (title, genre, author_id, publisher_id, publication_date, price, rating, format) VALUES
('The Namesake', 'Literary Fiction', 1, 1, '2023-09-01', 14.99, 4.2, 'physical'),
('Unaccustomed Earth', 'Literary Fiction', 1, 1, '2022-05-01', 15.99, 4.3, 'ebook'),
('Interpreter of Maladies', 'Literary Fiction', 1, 1, '2021-03-01', 13.99, 4.4, 'audiobook'),
('The Lowland', 'Literary Fiction', 1, 1, '2020-07-01', 16.99, 4.5, 'physical'),
('The God of Small Things', 'Thriller', 2, 2, '2023-06-01', 12.99, 4.5, 'ebook'),
('The Ministry of Utmost Happiness', 'Thriller', 2, 2, '2022-11-01', 14.99, 4.2, 'physical'),
('Capitalism: A Ghost Story', 'Comedy', 2, 2, '2021-08-01', 12.99, 4.0, 'ebook'),
('Field Notes on Democracy', 'Comedy', 2, 2, '2020-02-01', 13.99, 4.3, 'audiobook'),
('The Immortals of Meluha', 'Crime', 3, 1, '2023-02-01', 14.99, 4.5, 'physical'),
('The Secret of the Nagas', 'Crime', 3, 1, '2022-06-01', 15.99, 4.6, 'ebook'),
('The Oath of the Vayuputras', 'Crime', 3, 1, '2021-12-01', 16.99, 4.4, 'audiobook'),
('Scion of Ikshvaku', 'Crime', 3, 1, '2020-05-01', 13.99, 4.7, 'physical'),
('The Palace of Illusions', 'Mythology', 4, 2, '2023-02-01', 15.99, 4.4, 'ebook'),
('The Forest of Enchantments', 'Mythology', 4, 2, '2022-03-01', 14.99, 4.3, 'physical'),
('Before We Visit the Goddess', 'Mythology', 4, 2, '2021-07-01', 13.99, 4.2, 'audiobook'),
('The Last Queen', 'Mythology', 4, 2, '2020-10-01', 16.99, 4.1, 'physical');```

-- Create Sample Queries for CRUD Operations

-- Create a New Book
```INSERT INTO Books (title, genre, author_id, publisher_id, publication_date, price, rating, format)
VALUES ('The Last Archive', 'Historical Fiction', 4, 2, '2023-09-15', 21.99, 4.7, 'ebook');```

-- Read a Book by ID
```SELECT * FROM Books WHERE book_id = 1;```

-- Update a Book
```UPDATE Books SET title = 'Updated Title', genre = 'Updated Genre', price = 15.99 WHERE book_id = 1;```

-- Delete a Book
```DELETE FROM Books WHERE book_id = 1;```
... 

--- SQL QUERIES:

1) Power writers (authors) with more than X books in the same genre published within the last X years 

``` SELECT 
    b.author_id, 
    a.name, 
    b.genre,
    COUNT(*) AS book_count
FROM 
    Books b
JOIN 
    Authors a ON b.author_id = a.author_id
WHERE 
    b.publication_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY 
    b.author_id, a.name, b.genre
HAVING 
    COUNT(*) > 3;```

2) Loyal Customers who have spent more than X dollars in the last year

``SELECT c.name, o.order_date, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATE_TRUNC('year', NOW()) - INTERVAL '5 year'
GROUP BY c.customer_id, c.name, o.order_date
HAVING SUM(o.total_amount) > 58; ```


3) Well Reviewed Books that have a better user rating than average

``` SELECT 
    b.title, 
    b.rating,
    r.comment AS review
FROM 
    Books b
JOIN 
    Reviews r ON b.book_id = r.book_id
WHERE 
    b.rating > (SELECT AVG(rating) FROM Books);```

4) The most popular genre by sales:

```SELECT 
    b.genre, 
    SUM(oi.quantity) AS total_sold
FROM 
    Books b
JOIN 
    Order_Items oi ON b.book_id = oi.book_id
GROUP BY 
    b.genre
ORDER BY 
    total_sold DESC
LIMIT 1;```


5) The 10 most recent posted reviews by Customers:

``` SELECT 
    r.review_id, 
    r.comment, 
    r.review_date, 
    c.name AS customer_name, 
    b.title AS book_title
FROM 
    Reviews r
JOIN 
    Customers c ON r.customer_id = c.customer_id
JOIN 
    Books b ON r.book_id = b.book_id
ORDER BY 
    r.review_date DESC
LIMIT 10;```


# Typescript Interface

## Installation

### Prerequisites
- Node.js (version X.X.X)
- npm (version X.X.X)
- PostgreSQL

### Steps
1. Clone the repository:
    bash
    ```
    git clone https://github.com/shivi-1010/online_bookstore_midterm_dbt.git```
    ``` cd online_bookstore_midterm_dbt```
    
2. Install dependencies:
    
    ```npm install -g typescript```
    ```npm install typescript --save-dev```
    ```npm init -y```
    ```npx tsc --init```
    ```npm install pg```
    

3. Set up the database:
    
    ```psql -U postgres -d online_bookstore_midterm_dbt```
    

4. Initialize TypeScript:
    
   ``` tsc --init```
   ``` psql -U postgres```
    ```npm install -g ts-node```
    

## Running the TypeScript Modification

1. Compile and run the TypeScript file:
    
   ``` tsc BookService.ts```
    ```node BookService.js```
    

## Setting Up and Running the Express Server

1. Build the TypeScript project:
    
    ```npm install```
   ``` npm run build```
    

2. Start the Express application:
    
   ``` npm start```
    

### Expected Output 3000
This indicates that your Express server is up and running.

When you run npm start, you should see:
Server Running port on
## Running CRUD Operat
1. Test the CRUD operations:
    ```ts-node src/test.ts```
   ``` ts-node src/index.ts```
    ```ts-node src/BookService.ts```
    
Verifying Data Persistence
	1.	Start containers:
```docker-compose up -d```
	2.	Insert data:
Use Postman or another tool to insert a new book via your API:
```curl http://localhost:3000/books/1```
	3.	Check data:
Verify the book was inserted by retrieving it:
	4.	Stop containers:
```docker-compose down```
	5.	Restart containers:
```docker-compose up -d```
  6.	Verify data persistence:
Retrieve the book again to ensure it is still present:
```curl http://localhost:3000/books/1```
