-- =============================================
-- ESQUEMA COMPLETO - CLASE SQL JOIN
-- =============================================
CREATE DATABASE IF NOT EXISTS clase_joins;
USE clase_joins;
-- Tabla: users (1:1 con profiles)
CREATE TABLE users (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL
);
-- Tabla: profiles (1:1 con users)
CREATE TABLE profiles (
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT UNIQUE,
address VARCHAR(200),
phone VARCHAR(20),
FOREIGN KEY (user_id) REFERENCES users(id)
ON DELETE CASCADE ON UPDATE CASCADE
);
-- Tabla: clients (1:N con orders)
CREATE TABLE clients (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
city VARCHAR(80)
);
-- Tabla: orders (N:1 con clients)
CREATE TABLE orders (
id INT PRIMARY KEY AUTO_INCREMENT,
client_id INT,
order_date DATE,
total DECIMAL(10,2),
status VARCHAR(30) DEFAULT 'pendiente',
FOREIGN KEY (client_id) REFERENCES clients(id)
ON DELETE CASCADE
);
-- Tabla: products
CREATE TABLE products (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
price DECIMAL(10,2),
category VARCHAR(50)
);
-- Tabla: order_items (intermedia orders &lt;-&gt; products)
CREATE TABLE order_items (
order_id INT,
product_id INT,
quantity INT DEFAULT 1,
unit_price DECIMAL(10,2),
PRIMARY KEY (order_id, product_id),
FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
-- Tabla: students (N:M con courses)
CREATE TABLE students (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
email VARCHAR(100)
);
-- Tabla: courses
CREATE TABLE courses (
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(100) NOT NULL,
instructor VARCHAR(100),
credits INT DEFAULT 3
);
-- Tabla: student_course (intermedia students &lt;-&gt; courses)
CREATE TABLE student_course (
student_id INT,
course_id INT,
enrolled_at DATE,
grade DECIMAL(3,1),
PRIMARY KEY (student_id, course_id),
FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

INSERT INTO users (name, email) values
  ('Ana García',     'ana@example.com'),
  ('Luis Pérez',     'luis@example.com'),
  ('María López',    'maria@example.com'),
  ('Carlos Ruiz',    'carlos@example.com'),
  ('Sofía Torres',   'sofia@example.com'),
  ('Pedro Morales',  'pedro@example.com'),
  ('Laura Jiménez',  'laura@example.com'),
  ('Andrés Castro',  'andres@example.com'),
  ('Valentina Ríos', 'vale@example.com'),
  ('Diego Salazar',  'diego@example.com'),
  ('Isabel Vera',    'isabel@example.com'),
  ('Tomás Herrera',  'tomas@example.com');
INSERT INTO profiles (user_id, address, phone) VALUES
  (1,  'Calle 10 # 5-20, Bogotá',       '3001112233'),
  (2,  'Av. Siempre Viva 742, Medellín', '3114445566'),
  (3,  'Carrera 50 # 80-15, Cali',       '3207778899'),
  (4,  'Calle 15 # 3-10, Barranquilla',  '3159990011'),
  (5,  'Diagonal 40 # 12-5, Cúcuta',     '3002223344'),
  (6,  'Transversal 60 # 9-30, Pereira', '3135556677'),
  (7,  'Calle 72 # 45-60, Manizales',    '3188889900'),
  (9,  'Carrera 7 # 100-1, Bogotá',      '3101234567'),
  (10, 'Calle 93 # 15-30, Bogotá',       '3209876543');
-- users 8, 11, 12 NO tienen perfil (aparecerán en LEFT JOIN)
INSERT INTO clients (name, city) VALUES
  ('Supermercado El Éxito', 'Bogotá'),
  ('Ferretería Construya',  'Medellín'),
  ('Papelería Punto',       'Cali'),
  ('Restaurante Don Pedro', 'Barranquilla'),
  ('Librería Saber',        'Manizales'),
  ('Farmacia Salud',        'Pereira'),
  ('Tecnología Express',    'Bogotá'),
  ('Moda y Estilo',         'Cúcuta'),
  ('Deportes Total',        'Cartagena'),
  ('Auto Repuestos SAS',    'Bucaramanga'),
  ('Viajes Soñados',        'Santa Marta'),
  ('Sin Órdenes Ltda',      'Bogotá');
-- client 12 NO tiene pedidos (aparecerá en LEFT JOIN)
INSERT INTO orders (client_id, order_date, total, status) VALUES
  (1, '2024-01-10', 350000.00, 'entregado'),
  (1, '2024-02-14', 125000.50, 'entregado'),
  (2, '2024-01-22', 890000.00, 'entregado'),
  (2, '2024-03-05', 445000.75, 'pendiente'),
  (3, '2024-02-28', 67000.00,  'cancelado'),
  (4, '2024-03-15', 230000.00, 'entregado'),
  (4, '2024-04-01', 560000.00, 'en proceso'),
  (5, '2024-01-30', 42000.00,  'entregado'),
  (6, '2024-02-18', 315000.00, 'entregado'),
  (7, '2024-03-22', 1250000.00,'pendiente'),
  (7, '2024-04-10', 780000.00, 'en proceso'),
  (8, '2024-01-05', 95000.00,  'entregado'),
 (9, '2024-02-20', 432000.00, 'entregado'),
  (10,'2024-03-30', 670000.00, 'pendiente'),
  (11,'2024-04-05', 290000.00, 'cancelado');
-- client 12 NO tiene pedidos
INSERT INTO products (name, price, category) VALUES
  ('Laptop HP 15"',       2500000.00, 'Tecnología'),
  ('Mouse Inalámbrico',     85000.00, 'Tecnología'),
  ('Teclado Mecánico',     320000.00, 'Tecnología'),
  ('Monitor 24"',         950000.00, 'Tecnología'),
  ('Camisa Oxford',         75000.00, 'Ropa'),
  ('Pantalón Jeans',        95000.00, 'Ropa'),
  ('Zapatos de Cuero',     250000.00, 'Ropa'),
  ('Libro Bases de Datos',  65000.00, 'Educación'),
  ('Cuaderno Universitario', 8000.00, 'Educación'),
  ('Calculadora Científica',55000.00, 'Educación'),
  ('Balón de Fútbol',       80000.00, 'Deportes'),
  ('Raqueta de Tenis',     280000.00, 'Deportes'),
  ('Zapatillas Running',   350000.00, 'Deportes'),
  ('Vitamina C 1000mg',     35000.00, 'Salud'),
  ('Termómetro Digital',    45000.00, 'Salud');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
  (1,  2,  2,  85000.00),
  (1,  9,  5,   8000.00),
  (2,  5,  1,  75000.00),
  (2,  9,  3,   8000.00),
  (3,  1,  1, 2500000.00),
  (3,  3,  1,  320000.00),
  (4,  2,  3,   85000.00),
  (4,  10, 2,   55000.00),
  (5,  6,  2,   95000.00),
  (6,  11, 2,   80000.00),
  (6,  12, 1,  280000.00),
  (7,  1,  1, 2500000.00),
  (7,  4,  1,  950000.00),
  (8,  8,  1,   65000.00),
  (9,  14, 3,   35000.00),
  (9,  15, 4,   45000.00),
  (10, 1,  1, 2500000.00),
  (10, 2,  1,   85000.00),
  (10, 3,  1,  320000.00),
  (11, 4,  1,  950000.00),
  (11, 13, 1,  350000.00),
  (12, 5,  2,   75000.00),
  (12, 6,  1,   95000.00),
  (13, 11, 3,   80000.00),
  (13, 13, 1,  350000.00),
  (14, 1,  1, 2500000.00),
  (15, 8,  2,   65000.00),
  (15, 10, 2,   55000.00);
INSERT INTO students (name, email) VALUES
 ('Alejandro Gómez',  'alegomez@uni.edu'),
  ('Camila Navarro',   'cnavarro@uni.edu'),
  ('Felipe Vargas',    'fvargas@uni.edu'),
  ('Natalia Ospina',   'nospina@uni.edu'),
  ('Santiago Leal',    'sleal@uni.edu'),
  ('Daniela Mora',     'dmora@uni.edu'),
  ('Julián Arias',     'jarias@uni.edu'),
  ('Paola Quintero',   'pquintero@uni.edu'),
  ('Sebastián Forero', 'sforero@uni.edu'),
  ('Valentina Cruz',   'vcruz@uni.edu'),
  ('Sin Cursos Uno',   'sc1@uni.edu'),
  ('Sin Cursos Dos',   'sc2@uni.edu');
-- students 11 y 12 NO tienen cursos (LEFT JOIN)
INSERT INTO courses (title, instructor, credits) VALUES
  ('Bases de Datos I',       'Dr. Ramírez',   4),
  ('Algoritmos',             'Dra. Mendoza',  3),
  ('Redes de Computadores',  'Dr. Valencia',  3),
  ('Programación Web',       'Dra. Soto',     4),
  ('Inteligencia Artificial','Dr. Patiño',    3),
  ('Sistemas Operativos',    'Dra. Cárdenas', 3),
  ('Ingeniería de Software', 'Dr. Bermúdez',  4),
  ('Estadística Aplicada',   'Dra. Flórez',   3);

INSERT INTO student_course (student_id, course_id, enrolled_at, grade) VALUES
  (1, 1, '2024-01-15', 4.5),
  (1, 2, '2024-01-15', 3.8),
  (1, 4, '2024-01-15', 4.2),
  (2, 1, '2024-01-15', 3.5),
  (2, 3, '2024-01-15', 4.0),
  (2, 5, '2024-01-15', 4.7),
  (3, 2, '2024-01-15', 3.2),
  (3, 6, '2024-01-15', 4.1),
  (4, 1, '2024-01-15', 4.8),
  (4, 4, '2024-01-15', 3.9),
  (4, 7, '2024-01-15', 4.3),
  (5, 3, '2024-01-15', 3.7),
  (5, 5, '2024-01-15', 4.0),
  (6, 2, '2024-01-15', 4.5),
  (6, 6, '2024-01-15', 3.6),
  (6, 8, '2024-01-15', 4.4),
  (7, 1, '2024-01-15', 3.0),
  (7, 7, '2024-01-15', 3.8),
  (8, 4, '2024-01-15', 4.6),
  (8, 8, '2024-01-15', 4.1),
  (9, 5, '2024-01-15', 3.9),
  (9, 6, '2024-01-15', 4.2),
  (10,1, '2024-01-15', 4.9),
  (10,3, '2024-01-15', 4.7),
  (10,5, '2024-01-15', 4.8);
SELECT
  u.id,
  u.name        AS usuario,
  u.email,
  p.address     AS dirección,
  p.phone       AS teléfono
FROM users u
INNER JOIN profiles p ON u.id = p.user_id;
-- Resultado: sólo los 9 users que tienen perfil.
-- Los 3 sin perfil (id 8, 11, 12) NO aparecen.
SELECT
  c.name        AS cliente,
  c.city        AS ciudad,
  o.id          AS pedido,
  o.order_date  AS fecha,
  o.total,
  o.status      AS estado
FROM clients c
INNER JOIN orders o ON c.id = o.client_id
ORDER BY c.name, o.order_date;
SELECT
  o.id          AS pedido,
  c.name        AS cliente,
  p.name        AS producto,
  oi.quantity   AS cantidad,
  oi.unit_price AS precio_unitario,
  (oi.quantity * oi.unit_price) AS subtotal
FROM orders o
INNER JOIN clients    c  ON o.client_id    = c.id
INNER JOIN order_items oi ON o.id          = oi.order_id
INNER JOIN products   p  ON oi.product_id  = p.id
ORDER BY o.id;

SELECT
  s.name        AS estudiante,
  co.title      AS curso,
  co.instructor,
  sc.enrolled_at AS inscripcióñ,
  sc.grade       AS nota
FROM students s
INNER JOIN student_course sc ON s.id     = sc.student_id

INNER JOIN courses co        ON co.id    = sc.course_id
ORDER BY s.name, co.title;