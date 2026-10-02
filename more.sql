-- EJERCICIO 12
-- Top 5 productos más vendidos

SELECT
    p.name AS producto,
    p.category AS categoria,
    SUM(oi.quantity) AS unidades_vendidas,
    SUM(oi.quantity * oi.unit_price) AS ingreso_total
FROM products p
INNER JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.name, p.category
ORDER BY unidades_vendidas DESC
LIMIT 5;

-- EJERCICIO 13

SELECT
    c.name AS cliente,
    c.city AS ciudad,
    COUNT(o.id) AS num_pedidos,
    SUM(o.total) AS total_comprado
FROM clients c
INNER JOIN orders o ON c.id = o.client_id
GROUP BY c.id, c.name, c.city
HAVING total_comprado > 500000
ORDER BY total_comprado DESC;


-- EJERCICIO 14


SELECT
    co.title AS curso,
    s.name AS estudiante,
    ROUND(sc.grade, 1) AS nota
FROM student_course sc
INNER JOIN students s ON sc.student_id = s.id
INNER JOIN courses co ON sc.course_id = co.id
WHERE sc.grade = (
    SELECT MAX(grade)
    FROM student_course sc2
    WHERE sc2.course_id = sc.course_id
)
ORDER BY co.title;


-- EJERCICIO 15


SELECT
    o.id AS pedido,
    o.order_date AS fecha,
    c.name AS cliente,
    c.city AS ciudad,
    p.name AS producto,
    p.category AS categoria,
    oi.quantity AS cantidad,
    oi.unit_price AS precio,
    (oi.quantity * oi.unit_price) AS subtotal
FROM orders o
INNER JOIN clients c ON o.client_id = c.id
INNER JOIN order_items oi ON o.id = oi.order_id
INNER JOIN products p ON oi.product_id = p.id
WHERE o.status = 'entregado'
ORDER BY o.id, p.name;


-- EJERCICIO 16  Promedio de notas por curso


SELECT
    co.title AS curso,
    co.instructor,
    co.credits AS creditos,
    COUNT(sc.student_id) AS inscritos,
    ROUND(AVG(sc.grade), 2) AS promedio_nota,
    MAX(sc.grade) AS nota_maxima,
    MIN(sc.grade) AS nota_minima
FROM courses co
LEFT JOIN student_course sc ON co.id = sc.course_id
GROUP BY co.id, co.title, co.instructor, co.credits
ORDER BY promedio_nota DESC;

-- EJERCICIO 17
-- Ventas por categoría de producto

SELECT
    p.category AS categoria,
    COUNT(DISTINCT o.id) AS pedidos_con_categoria,
    SUM(oi.quantity) AS unidades_totales,
    SUM(oi.quantity * oi.unit_price) AS ingresos
FROM products p
INNER JOIN order_items oi ON p.id = oi.product_id
INNER JOIN orders o ON o.id = oi.order_id
GROUP BY p.category
ORDER BY ingresos DESC;
