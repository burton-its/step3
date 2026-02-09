-- template created with AI(chatgpt), information populated by Corey Burton/Henry Koster

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

