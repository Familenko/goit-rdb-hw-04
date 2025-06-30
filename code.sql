-- 1

CREATE SCHEMA `LibraryManagement` ;

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 2

INSERT INTO authors (author_name) VALUES 
('Кітайський Льоша'),
('Укарїнський Льоша');

INSERT INTO genres (genre_name) VALUES 
('Антиутопія'),
('Утопія');

INSERT INTO books (title, publication_year, author_id, genre_id) VALUES 
('Китайська книга рецептів', 2022, 1, 1),
('Українська книга рецептів', 2024, 2, 2);

INSERT INTO users (username, email) VALUES 
('oleksiy', 'oleksiy@example.com'),
('nastia', 'nastia@example.com');

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES 
(1, 1, '2025-06-20', '2025-07-01'),
(2, 2, '2025-06-25', '2025-07-10');

-- 3

SELECT *
FROM `new_schema1`.`order_details`
INNER JOIN `orders` on `orders`.`id` = `order_details`.`order_id`
INNER JOIN `customers` on `orders`.`customer_id` = `customers`.`id`
INNER JOIN `products` on `order_details`.`product_id` = `products`.`id`
INNER JOIN `categories` on `products`.`category_id` = `categories`.`id`
INNER JOIN `employees` on `orders`.`employee_id` = `employees`.`employee_id`
INNER JOIN `shippers` on `orders`.`shipper_id` = `shippers`.`id`
INNER JOIN `suppliers` on `products`.`supplier_id` = `suppliers`.`id`

-- 4

-- 4.1
-- Визначте, скільки рядків ви отримали (за допомогою оператора COUNT).

SELECT COUNT(*)
FROM `new_schema1`.`order_details`
INNER JOIN `orders` on `orders`.`id` = `order_details`.`order_id`
INNER JOIN `customers` on `orders`.`customer_id` = `customers`.`id`
INNER JOIN `products` on `order_details`.`product_id` = `products`.`id`
INNER JOIN `categories` on `products`.`category_id` = `categories`.`id`
INNER JOIN `employees` on `orders`.`employee_id` = `employees`.`employee_id`
INNER JOIN `shippers` on `orders`.`shipper_id` = `shippers`.`id`
INNER JOIN `suppliers` on `products`.`supplier_id` = `suppliers`.`id`

-- отримано 518 рядків

-- 4.2
-- Змініть декілька операторів INNER на LEFT чи RIGHT. Визначте, що відбувається з кількістю рядків. Чому? Напишіть відповідь у текстовому файлі.

SELECT COUNT(*)
FROM `new_schema1`.`order_details`
LEFT JOIN `orders` on `orders`.`id` = `order_details`.`order_id`
LEFT JOIN `customers` on `orders`.`customer_id` = `customers`.`id`
LEFT JOIN `products` on `order_details`.`product_id` = `products`.`id`
RIGHT JOIN `categories` on `products`.`category_id` = `categories`.`id`
LEFT JOIN `employees` on `orders`.`employee_id` = `employees`.`employee_id`
LEFT JOIN `shippers` on `orders`.`shipper_id` = `shippers`.`id`
LEFT JOIN `suppliers` on `products`.`supplier_id` = `suppliers`.`id`

-- отримано тіж самі 518 рядків. моя відповідь на питання "Чому?" "Томущо"

-- 4.3
-- На основі запита з пункта 3 виконайте наступне: оберіть тільки ті рядки, де employee_id > 3 та ≤ 10.

SELECT *
FROM `new_schema1`.`order_details`
INNER JOIN `orders` on `orders`.`id` = `order_details`.`order_id`
INNER JOIN `customers` on `orders`.`customer_id` = `customers`.`id`
INNER JOIN `products` on `order_details`.`product_id` = `products`.`id`
INNER JOIN `categories` on `products`.`category_id` = `categories`.`id`
INNER JOIN `employees` on `orders`.`employee_id` = `employees`.`employee_id`
INNER JOIN `shippers` on `orders`.`shipper_id` = `shippers`.`id`
INNER JOIN `suppliers` on `products`.`supplier_id` = `suppliers`.`id`

WHERE `orders`.`employee_id` > 3 AND `orders`.`employee_id` <= 10

-- 4.4
-- Згрупуйте за іменем категорії, порахуйте кількість рядків у групі, середню кількість товару (кількість товару знаходиться в order_details.quantity)

SELECT 
    categories.category_name,
    COUNT(*) AS total_rows,
    AVG(order_details.quantity) AS avg_quantity
FROM `new_schema1`.`order_details`
INNER JOIN `orders` ON `orders`.`id` = `order_details`.`order_id`
INNER JOIN `customers` ON `orders`.`customer_id` = `customers`.`id`
INNER JOIN `products` ON `order_details`.`product_id` = `products`.`id`
INNER JOIN `categories` ON `products`.`category_id` = `categories`.`id`
INNER JOIN `employees` ON `orders`.`employee_id` = `employees`.`employee_id`
INNER JOIN `shippers` ON `orders`.`shipper_id` = `shippers`.`id`
INNER JOIN `suppliers` ON `products`.`supplier_id` = `suppliers`.`id`
GROUP BY categories.category_name
ORDER BY categories.category_name;

-- 4.5
-- Відфільтруйте рядки, де середня кількість товару більша за 21.

SELECT 
    categories.name,
    COUNT(*) AS total_rows,
    AVG(order_details.quantity) AS avg_quantity
FROM `new_schema1`.`order_details`
INNER JOIN `orders` ON `orders`.`id` = `order_details`.`order_id`
INNER JOIN `customers` ON `orders`.`customer_id` = `customers`.`id`
INNER JOIN `products` ON `order_details`.`product_id` = `products`.`id`
INNER JOIN `categories` ON `products`.`category_id` = `categories`.`id`
INNER JOIN `employees` ON `orders`.`employee_id` = `employees`.`employee_id`
INNER JOIN `shippers` ON `orders`.`shipper_id` = `shippers`.`id`
INNER JOIN `suppliers` ON `products`.`supplier_id` = `suppliers`.`id`
GROUP BY categories.name
HAVING avg_quantity > 21
ORDER BY categories.name

-- 4.6
-- Відсортуйте рядки за спаданням кількості рядків.

SELECT 
    categories.name,
    COUNT(*) AS total_rows,
    AVG(order_details.quantity) AS avg_quantity
FROM `new_schema1`.`order_details`
INNER JOIN `orders` ON `orders`.`id` = `order_details`.`order_id`
INNER JOIN `customers` ON `orders`.`customer_id` = `customers`.`id`
INNER JOIN `products` ON `order_details`.`product_id` = `products`.`id`
INNER JOIN `categories` ON `products`.`category_id` = `categories`.`id`
INNER JOIN `employees` ON `orders`.`employee_id` = `employees`.`employee_id`
INNER JOIN `shippers` ON `orders`.`shipper_id` = `shippers`.`id`
INNER JOIN `suppliers` ON `products`.`supplier_id` = `suppliers`.`id`
GROUP BY categories.name
HAVING avg_quantity > 21
ORDER BY avg_quantity DESC

-- 4.7
-- Виведіть на екран (оберіть) чотири рядки з пропущеним першим рядком.

SELECT 
    categories.name,
    COUNT(*) AS total_rows,
    AVG(order_details.quantity) AS avg_quantity
FROM `new_schema1`.`order_details`
INNER JOIN `orders` ON `orders`.`id` = `order_details`.`order_id`
INNER JOIN `customers` ON `orders`.`customer_id` = `customers`.`id`
INNER JOIN `products` ON `order_details`.`product_id` = `products`.`id`
INNER JOIN `categories` ON `products`.`category_id` = `categories`.`id`
INNER JOIN `employees` ON `orders`.`employee_id` = `employees`.`employee_id`
INNER JOIN `shippers` ON `orders`.`shipper_id` = `shippers`.`id`
INNER JOIN `suppliers` ON `products`.`supplier_id` = `suppliers`.`id`
GROUP BY categories.name
HAVING avg_quantity > 21
ORDER BY avg_quantity DESC
LIMIT 4 OFFSET 1
