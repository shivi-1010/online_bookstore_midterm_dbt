-- init.sql

CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    biography TEXT
);

CREATE TABLE Publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200)
);

CREATE TABLE Books (
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
);

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    total_spent DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    book_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Authors (name, biography) VALUES
 ('Jhumpa Lahiri', 'Indian-American author known for her works exploring the immigrant experience.'),
 ('Arundhati Roy', 'Indian author and political activist, best known for her novel "The God of Small Things."'),
 ('Kiran Desai', 'Indian author known for her novel "The Inheritance of Loss," which won the Man Booker Prize.'),
 ('Aravind Adiga', 'Indian-Australian author, winner of the Man Booker Prize for his debut novel "The White Tiger."'),
 ('Chitra Banerjee Divakaruni', 'Indian-American author known for her novels exploring Indian culture and immigrant experiences.'),
 ('Ravi Subramanian', 'Indian author known for his financial thrillers set in the corporate world.'),
 ('Amish Tripathi', 'Indian author known for his novels in the mythological fiction genre, including the "Shiva Trilogy."'),
 ('Ashwin Sanghi', 'Indian author known for his historical fiction novels, often blending myth and modern-day thriller elements.'),
 ('Mark Manson', 'American author known for his crime book "The Subtle Art of Crime."'),
 ('Tara Westover', 'American author known for her memoir "Educated," which details her journey from a survivalist family to earning a PhD from Cambridge University.');

INSERT INTO Publishers (name, address) VALUES
('Penguin Random House', '1745 Broadway, New York, NY 10019, USA'),
('HarperCollins Publishers', '195 Broadway, New York, NY 10007, USA'),
('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020, USA'),
('Hachette Book Group', '1290 Avenue of the Americas, New York, NY 10104, USA'),
('Macmillan Publishers', '120 Broadway, New York, NY 10271, USA'),
('Scholastic Corporation', '557 Broadway, New York, NY 10012, USA'),
('Oxford University Press', 'Great Clarendon Street, Oxford OX2 6DP, United Kingdom'),
('Cambridge University Press', 'University Printing House, Shaftesbury Road, Cambridge CB2 8BS, United Kingdom'),
('Bloomsbury Publishing', '50 Bedford Square, London WC1B 3DP, United Kingdom'),
('Houghton Mifflin Harcourt', '125 High Street, Boston, MA 02110, USA');

INSERT INTO Books (title, genre, author_id, publisher_id, publication_date, price, rating, format) VALUES
('The Namesake', 'Literary Fiction', 1, 1, '2023-09-01', 14.99, 4.2, 'physical'),
('The God of Small Things', 'Literary Fiction', 2, 2, '2023-06-01', 12.99, 4.5, 'ebook'),
('The Inheritance of Loss', 'Literary Fiction', 3, 3, '2023-01-01', 16.99, 4.1, 'audiobook'),
('The White Tiger', 'Literary Fiction', 4, 4, '2023-04-01', 13.99, 4.3, 'physical'),
('The Palace of Illusions', 'Mythology', 5, 5, '2023-02-01', 15.99, 4.4, 'ebook'),
('The Bestseller She Wrote', 'Romance', 6, 6, '2010-10-01', 12.99, 4.2, 'audiobook'),
('The Immortals of Meluha', 'Mythology', 7, 7, '2023-02-01', 14.99, 4.5, 'physical'),
('The Krishna Key', 'Thriller', 8, 8, '2012-08-01', 16.99, 4.3, 'ebook'),
('The Shiva Trilogy', 'Mythology', 9, 9, '2023-03-01', 19.99, 4.6, 'audiobook'),
('Scion of Ikshvaku', 'Mythology', 10, 10, '2023-06-01', 18.99, 4.4, 'physical');

INSERT INTO Customers (name, email, total_spent) VALUES
('John Doe', 'john.doe@email.com', 250.75),
('Jane Smith', 'jane.smith@email.com', 105.99),
('Michael Johnson', 'michael.johnson@email.com', 375.25),
('Emily Davis', 'emily.davis@email.com', 89.50),
('David Wilson', 'david.wilson@email.com', 620.00),
('Sarah Thompson', 'sarah.thompson@email.com', 175.40),
('Robert Anderson', 'robert.anderson@email.com', 95.25),
('Jessica Taylor', 'jessica.taylor@email.com', 310.80),
('Christopher Brown', 'christopher.brown@email.com', 425.65),
('Ashley Miller', 'ashley.miller@email.com', 160.15);

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2023-05-01', 45.99),
(2, '2021-05-03', 25.75),
(3, '2022-05-05', 105.50),
(4, '2022-05-07', 18.99),
(5, '2019-05-10', 75.25),
(6, '2020-05-12', 35.80),
(7, '2023-05-15', 62.40),
(8, '2020-05-18', 95.75),
(9, '2023-05-20', 120.99),
(10, '2023-05-22', 40.25);

INSERT INTO Order_Items (order_id, book_id, quantity) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 5, 1),
(3, 2, 2),
(3, 7, 1),
(4, 9, 1),
(5, 4, 1),
(5, 6, 1),
(6, 8, 2),
(7, 10, 1),
(7, 3, 1),
(7, 5, 1),
(8, 1, 2),
(8, 6, 1),
(8, 9, 1),
(9, 7, 2),
(9, 4, 1),
(9, 2, 1),
(10, 8, 2),
(10, 5, 1);

INSERT INTO Reviews (customer_id, book_id, rating, comment, review_date) VALUES
(1, 2, 4, 'A captivating story with unexpected twists and turns.', '2023-01-10'),
(2, 4, 5, 'Heartwarming and uplifting, a must-read for everyone.', '2019-02-14'),
(3, 5, 2, 'The plot was slow and I found it difficult to stay engaged.', '2020-03-12'),
(4, 6, 3, 'A detailed exploration of complex themes, but quite dense.', '2021-06-23'),
(5, 7, 4, 'A touching narrative with well-developed characters.', '2022-07-30'),
(6, 8, 5, 'Absolutely riveting from start to finish. Couldn’t put it down!', '2023-09-18'),
(7, 9, 3, 'Thought-provoking but the writing style wasn’t for me.', '2023-08-12'),
(8, 1, 4, 'A fantastic journey through an imaginative world.', '2023-11-25'),
(9, 3, 2, 'The story was good but the pacing was a bit slow.', '2022-12-06'),
(10, 10, 5, 'An inspiring tale of resilience and hope.', '2021-05-15');
