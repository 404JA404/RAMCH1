-- EJERCICIO 5
-- Todos los usuarios, tengan o no perfil

SELECT
    u.id,
    u.name AS usuario,
    p.address AS direccion,
    p.phone AS telefono,
    CASE
        WHEN p.user_id IS NULL THEN 'Sin perfil'
        ELSE 'Con perfil'
    END AS estado_perfil
FROM users u
LEFT JOIN profiles p ON u.id = p.user_id
ORDER BY estado_perfil, u.name;

-- EJERCICIO 6
-- Clientes sin ningun pedido

SELECT
    c.id,
    c.name AS cliente,
    c.city AS ciudad
FROM clients c
LEFT JOIN orders o ON c.id = o.client_id
WHERE o.id IS NULL;


-- EJERCICIO 7
-- Numero de pedidos por cliente


SELECT
    c.name AS cliente,
    c.city AS ciudad,
    COUNT(o.id) AS total_pedidos,
    COALESCE(SUM(o.total), 0) AS monto_total
FROM clients c
LEFT JOIN orders o ON c.id = o.client_id
GROUP BY c.id, c.name, c.city
ORDER BY total_pedidos DESC;


-- EJERCICIO 8 estudiantes sin cursos inscritos


SELECT
    s.id,
    s.name AS estudiante,
    s.email
FROM students s
LEFT JOIN student_course sc ON s.id = sc.student_id
WHERE sc.student_id IS NULL;


-- EJERCICIO 9 - RIGHT JOIN

SELECT
    co.title AS curso,
    co.instructor,
    co.credits AS creditos,
    s.name AS estudiante
FROM student_course sc
RIGHT JOIN courses co ON sc.course_id = co.id
LEFT JOIN students s ON sc.student_id = s.id
ORDER BY co.title, s.name;

-- EJERCICIO 10 - CROSS JOIN

SELECT
    c.name AS cliente,
    p.name AS producto,
    p.price AS precio
FROM clients c
CROSS JOIN products p
WHERE p.category = 'Tecnología'
ORDER BY c.name, p.name;



-- EJERCICIO 11 - SELF JOIN  Clientes que viven en la misma ciudad

SELECT
    c1.name AS cliente_1,
    c2.name AS cliente_2,
    c1.city AS ciudad
FROM clients c1
INNER JOIN clients c2
    ON c1.city = c2.city
    AND c1.id < c2.id
ORDER BY c1.city, c1.name;

