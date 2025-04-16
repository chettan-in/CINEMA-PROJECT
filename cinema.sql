create database chetan;
use chetan;
-- 1. Movies
CREATE TABLE Movies (
  movie_id INT PRIMARY KEY,
  title VARCHAR(100),
  genre VARCHAR(50),
  duration INT,
  release_date DATE
);

INSERT INTO Movies VALUES
(1, 'Inception', 'Sci-Fi', 148, '2010-07-16'),
(2, 'The Dark Knight', 'Action', 152, '2008-07-18'),
(3, 'Interstellar', 'Sci-Fi', 169, '2014-11-07'),
(4, 'Avengers: Endgame', 'Action', 181, '2019-04-26'),
(5, 'Titanic', 'Romance', 195, '1997-12-19'),
(6, 'Joker', 'Drama', 122, '2019-10-04'),
(7, 'Frozen', 'Animation', 102, '2013-11-27'),
(8, 'The Lion King', 'Animation', 118, '1994-06-24');

-- 2. Theaters
CREATE TABLE Theaters (
  theater_id INT PRIMARY KEY,
  name VARCHAR(100),
  location VARCHAR(100)
);

INSERT INTO Theaters VALUES
(1, 'Cineplex 1', 'New York'),
(2, 'MovieTown', 'Los Angeles'),
(3, 'Galaxy Theater', 'Chicago'),
(4, 'Fun Cinemas', 'Houston'),
(5, 'PVR Mall', 'San Francisco'),
(6, 'IMAX Central', 'Boston'),
(7, 'Grand Screens', 'Seattle'),
(8, 'Urban Cine', 'Miami');

-- 3. Screens
CREATE TABLE Screens (
  screen_id INT PRIMARY KEY,
  theater_id INT,
  screen_number INT,
  seat_capacity INT,
  FOREIGN KEY (theater_id) REFERENCES Theaters(theater_id)
);

INSERT INTO Screens VALUES
(1, 1, 1, 150),
(2, 2, 1, 200),
(3, 3, 2, 180),
(4, 4, 1, 120),
(5, 5, 3, 160),
(6, 6, 2, 140),
(7, 7, 1, 130),
(8, 8, 2, 170);

-- 4. Shows
CREATE TABLE Shows (
  show_id INT PRIMARY KEY,
  movie_id INT,
  screen_id INT,
  show_time TIME,
  show_date DATE,
  FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
  FOREIGN KEY (screen_id) REFERENCES Screens(screen_id)
);

INSERT INTO Shows VALUES
(1, 1, 1, '14:00:00', '2025-04-07'),
(2, 2, 2, '17:30:00', '2025-04-07'),
(3, 3, 3, '19:00:00', '2025-04-07'),
(4, 4, 4, '13:00:00', '2025-04-07'),
(5, 5, 5, '15:30:00', '2025-04-07'),
(6, 6, 6, '18:00:00', '2025-04-07'),
(7, 7, 7, '16:00:00', '2025-04-07'),
(8, 8, 8, '20:00:00', '2025-04-07');

-- 5. Customers
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(15)
);

INSERT INTO Customers VALUES
(1, 'Alice Johnson', 'alice@gmail.com', '1234567890'),
(2, 'Bob Smith', 'bob@gmail.com', '2345678901'),
(3, 'Cathy Brown', 'cathy@gmail.com', '3456789012'),
(4, 'David Lee', 'david@gmail.com', '4567890123'),
(5, 'Eva Green', 'eva@gmail.com', '5678901234'),
(6, 'Frank Hall', 'frank@gmail.com', '6789012345'),
(7, 'Grace White', 'grace@gmail.com', '7890123456'),
(8, 'Henry Black', 'henry@gmail.com', '8901234567');

-- 6. Bookings
CREATE TABLE Bookings (
  booking_id INT PRIMARY KEY,
  customer_id INT,
  show_id INT,
  number_of_seats INT,
  booking_date DATE,
  total_amount DECIMAL(8,2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);

INSERT INTO Bookings VALUES
(1, 1, 1, 2, '2025-04-06', 20.00),
(2, 2, 2, 3, '2025-04-06', 30.00),
(3, 3, 3, 1, '2025-04-06', 10.00),
(4, 4, 4, 4, '2025-04-06', 40.00),
(5, 5, 5, 2, '2025-04-06', 20.00),
(6, 6, 6, 3, '2025-04-06', 30.00),
(7, 7, 7, 2, '2025-04-06', 20.00),
(8, 8, 8, 1, '2025-04-06', 10.00);
select*from Bookings;

SELECT * FROM Movies
WHERE release_date > '2010-01-01';

SELECT * FROM Theaters
WHERE location = 'New York';

SELECT * FROM Bookings
WHERE number_of_seats > 2;

SELECT * FROM Shows
WHERE show_date = '2025-04-07';

SELECT customer_id, SUM(total_amount) AS total_spent
FROM Bookings
GROUP BY customer_id;

SELECT genre, COUNT(*) AS movie_count
FROM Movies
GROUP BY genre;

SELECT AVG(seat_capacity) AS avg_capacity
FROM Screens;

SELECT booking_date, COUNT(*) AS total_bookings
FROM Bookings
GROUP BY booking_date;

SELECT m.title, s.show_time, t.name AS theater_name
FROM Shows s
JOIN Movies m ON s.movie_id = m.movie_id
JOIN Screens sc ON s.screen_id = sc.screen_id
JOIN Theaters t ON sc.theater_id = t.theater_id;

SELECT b.booking_id, c.name AS customer_name, b.total_amount
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id;

SELECT movie_id, COUNT(*) AS show_count
FROM Shows
GROUP BY movie_id
HAVING COUNT(*) < 3;

SELECT c.name AS customer_name, m.title AS movie_title, b.booking_date
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
ORDER BY b.booking_date DESC
LIMIT 1;

SELECT c.name AS customer_name, m.title AS movie_title, b.booking_date
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
ORDER BY b.booking_date DESC;
