DROP TABLE IF EXISTS book_page_reads;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS book_purchases;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS books;

PRAGMA foreign_keys = ON;

CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    blurb TEXT NOT NULL
);

INSERT INTO
    books(title, blurb)
VALUES
    ("Green Crusade", "A book about the apocalypse"), ("Moonlight Radio", "The lonely life of a midnight radio DJ"), ("Alien King's Prize", "The romance of a king and his human servant"), ("Anthriel", "A venture into the depths of an unknown world");



CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    area VARCHAR(255),
    book_purchased INTEGER NOT NULL,

    FOREIGN KEY (book_purchased) REFERENCES books(id)
);

INSERT INTO
    customers (email, first_name, area, book_purchased)
SELECT
    "*****o@gmail.com", "M****", "SW", 3
FROM
    books
WHERE   
    books.title = "Alien King's Prize";

INSERT INTO
    customers(email, first_name, area, book_purchased)
SELECT
    "u****@umich.edu", "M*****d", "MW", books.id
FROM
    books
WHERE   
    books.title = "Anthriel";

INSERT INTO
    customers(email, first_name, area, book_purchased)
SELECT
    "*r****@yahoo.com", "***d**", "NW", books.id
FROM
    books
WHERE   
    books.title = "Moonlight Radio"; 

INSERT INTO
    customers(email, first_name, area, book_purchased)
SELECT
    "*l****@gmail.com", "***q**", "SE", books.id
FROM
    books
WHERE   
    books.title = "Green Crusade";

INSERT INTO
    customers(email, first_name, area, book_purchased)
SELECT
    "*l****@gmail.com", "***q**", "SE", books.id
FROM
    books
WHERE   
    books.title = "Moonlight Radio";

INSERT INTO
    customers(email, first_name, area, book_purchased)
SELECT
    "b****@aol.com", "B**q**", "NE", books.id
FROM
    books
WHERE   
    books.title = "Anthriel";


CREATE TABLE book_purchases(
    id INTEGER PRIMARY KEY,
    book_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,

    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO
  book_purchases (book_id, customer_id)
VALUES
    ((SELECT id FROM books WHERE title = "Anthriel"),
    (SELECT id FROM customers WHERE email = "b****@aol.com" AND first_name = "B**q**")),

    ((SELECT id FROM books WHERE title = "Anthriel"),
    (SELECT id FROM customers WHERE email = "u****@umich.edu" AND first_name = "M*****d")),

    ((SELECT id FROM books WHERE title = "Green Crusade"),
    (SELECT id FROM customers WHERE email = "*l****@gmail.com" AND first_name = "***q**")),

    ((SELECT id FROM books WHERE title = "Alien King's Prize"),
    (SELECT id FROM customers WHERE email = "*****o@gmail.com" AND first_name = "M****")),     

    ((SELECT id FROM books WHERE title = "Moonlight Radio"),
    (SELECT id FROM customers WHERE email = "*r****@yahoo.com" AND first_name = "***d**")),

     ((SELECT id FROM books WHERE title = "Moonlight Radio"),
    (SELECT id FROM customers WHERE email = "*l****@gmail.com" AND first_name = "***q**")
);

CREATE TABLE reviews(
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    book_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    rating INTEGER NOT NULL,
    parent_reply_id INTEGER,

    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (parent_reply_id) REFERENCES reviews(id)

);

INSERT INTO
  reviews (body, book_id, customer_id, rating, parent_reply_id)
VALUES
  ("A bit too heavy on the action scenes. Really enjoyed the character interaction though!",
  (SELECT id FROM books WHERE title = "Anthriel"),
  (SELECT id FROM customers WHERE email = "b****@aol.com" AND first_name = "B**q**"),
  4,
  NULL),

  ("Quite dramatic and heartfelt, although the verbage was sort of too flowery.",
  (SELECT id FROM books WHERE title = "Moonlight Radio"),
  (SELECT id FROM customers WHERE email = "*r****@yahoo.com" AND first_name = "***d**"),
  4,
  NULL),

  ("I felt that the character interactions were pretty cliche.",
  (SELECT id FROM books WHERE title = "Green Crusade"),
  (SELECT id FROM customers WHERE email = "u****@umich.edu" AND first_name = "M*****d"),
  3,
  (SELECT id FROM reviews WHERE body = "A bit too heavy on the action scenes. Really enjoyed the character interaction though!")
);

CREATE TABLE book_page_reads(
    id INTEGER PRIMARY KEY,
    page_reads INTEGER,
    book_id INTEGER NOT NULL,

    FOREIGN KEY (book_id) REFERENCES books(id)
);

INSERT INTO 
    book_page_reads (page_reads, book_id)
VALUES
    (32021, (SELECT id FROM books WHERE title = "Anthriel")),
    (7890, (SELECT id FROM books WHERE title = "Green Crusade")),
    (446, (SELECT id FROM books WHERE title = "Moonlight Radio")),
    (5337, (SELECT id FROM books WHERE title = "Alien King's Prize")


);
