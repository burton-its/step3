-- template created with AI(chatgpt), information populated by Corey Burton/Henry Koster
-- create
-- patients
INSERT INTO patient (first_name, last_name, email, phone) VALUES
('Corey', 'Burton', 'burton.corey@gmail.com', '555-1010'),
('Henry', 'Koster', 'koster.henry@gmail.com', '555-1011'),
('Cloud', 'Strife', 'strife.cloud@gmail.com', '555-0598');

-- procedure types
INSERT INTO procedure_type (name, description) VALUES
('Filling', 'Dental cavity filling'),
('Crown', 'Dental crown placement'),
('Cleaning', 'Routine dental cleaning');

-- inventory (products)
INSERT INTO inventory (product_name, unit_cost) VALUES
('Composite Resin', 25.00),
('Dental Crown', 120.00),
('Anesthetic', 10.00);

-- employees
INSERT INTO employee (first_name, last_name, role) VALUES
('Mary', 'Taylor', 'Dentist'),
('Adam', 'Gray', 'Hygienist'),
('Bob', 'Adams', 'Assistant');

-- procedures
INSERT INTO `procedure` (patient_id, procedure_date, procedure_type_id) VALUES
(1, '2024-01-10', 1),
(2, '2024-01-12', 3),
(3, '2024-01-15', 2);

-- procedure_employee
INSERT INTO procedure_employee (procedure_id, employee_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 1);

-- procedure_inventory
INSERT INTO procedure_inventory (procedure_id, product_id, quantity_used) VALUES
(1, 1, 1),
(2, 3, 1),
(3, 2, 1);

-- get all patients
SELECT * 
FROM patient;

-- read procedure types with patient
SELECT p.procedure_id, pat.first_name, pat.last_name, pt.name AS procedure_type,
        p.procedure_date
FROM `procedure` p
JOIN patient pat ON p.patient_id = pat.patient_id
JOIN procedure_type pt ON p.procedure_type_id = pt.procedure_type_id
ORDER BY p.procedure_id;


-- update

UPDATE patient
SET phone = 555-2020
WHERE email = 'burton.corey@gmail.com';


-- delete
DELETE FROM procedure_inventory
WHERE procedure_id = 2 AND product_id = 3;
