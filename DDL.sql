DELIMITER //

DROP PROCEDURE IF EXISTS sp_reset_db//
CREATE PROCEDURE sp_reset_db()
BEGIN
  -- Make this reset predictable
  SET FOREIGN_KEY_CHECKS = 0;

  START TRANSACTION;

  -- Drops (junctions first)
  DROP TABLE IF EXISTS procedure_inventory;
  DROP TABLE IF EXISTS procedure_employee;
  DROP TABLE IF EXISTS `procedure`;
  DROP TABLE IF EXISTS employee;
  DROP TABLE IF EXISTS inventory;
  DROP TABLE IF EXISTS procedure_type;
  DROP TABLE IF EXISTS patient;

  -- patient
  CREATE TABLE patient (
      patient_id INT NOT NULL AUTO_INCREMENT,
      first_name VARCHAR(45) NOT NULL,
      last_name  VARCHAR(45) NOT NULL,
      email      VARCHAR(255) NOT NULL,
      phone      VARCHAR(20) NOT NULL,
      PRIMARY KEY (patient_id),
      UNIQUE (email)
  );

  -- procedure type
  CREATE TABLE procedure_type (
      procedure_type_id INT NOT NULL AUTO_INCREMENT,
      name        VARCHAR(45) NOT NULL,
      description VARCHAR(145) NOT NULL,
      PRIMARY KEY (procedure_type_id)
  );

  -- inventory
  CREATE TABLE inventory (
      product_id INT NOT NULL AUTO_INCREMENT,
      product_name VARCHAR(45) NOT NULL,
      unit_cost DECIMAL(10,2) NOT NULL,
      PRIMARY KEY (product_id)
  );

  -- employee
  CREATE TABLE employee (
      employee_id INT NOT NULL AUTO_INCREMENT,
      first_name VARCHAR(45) NOT NULL,
      last_name  VARCHAR(45) NOT NULL,
      role       VARCHAR(45) NOT NULL,
      PRIMARY KEY (employee_id)
  );

  -- procedure
  CREATE TABLE `procedure` (
      procedure_id INT NOT NULL AUTO_INCREMENT,
      patient_id INT NOT NULL,
      procedure_date DATE NOT NULL,
      procedure_type_id INT NOT NULL,
      PRIMARY KEY (procedure_id),
      FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
        ON DELETE CASCADE,
      FOREIGN KEY (procedure_type_id) REFERENCES procedure_type(procedure_type_id)
        ON DELETE CASCADE
  );

  -- junction: procedure <-> employee
  CREATE TABLE procedure_employee (
      procedure_id INT NOT NULL,
      employee_id INT NOT NULL,
      PRIMARY KEY (procedure_id, employee_id),
      FOREIGN KEY (procedure_id) REFERENCES `procedure`(procedure_id)
        ON DELETE CASCADE,
      FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
        ON DELETE CASCADE
  );

  -- junction: procedure <-> inventory
  CREATE TABLE procedure_inventory (
      procedure_id INT NOT NULL,
      product_id INT NOT NULL,
      quantity_used INT NOT NULL,
      PRIMARY KEY (procedure_id, product_id),
      FOREIGN KEY (procedure_id) REFERENCES `procedure`(procedure_id)
        ON DELETE CASCADE,
      FOREIGN KEY (product_id) REFERENCES inventory(product_id)
        ON DELETE CASCADE
  );

  -- seed data
  INSERT INTO patient (first_name, last_name, email, phone) VALUES
  ('Corey', 'Burton', 'burton.corey@gmail.com', '555-1010'),
  ('Henry', 'Koster', 'koster.henry@gmail.com', '555-1011'),
  ('Cloud', 'Strife', 'strife.cloud@gmail.com', '555-0598');

  INSERT INTO procedure_type (name, description) VALUES
  ('Filling', 'Dental cavity filling'),
  ('Crown', 'Dental crown placement'),
  ('Cleaning', 'Routine dental cleaning');

  INSERT INTO inventory (product_name, unit_cost) VALUES
  ('Composite Resin', 25.00),
  ('Dental Crown', 120.00),
  ('Anesthetic', 10.00);

  INSERT INTO employee (first_name, last_name, role) VALUES
  ('Mary', 'Taylor', 'Dentist'),
  ('Adam', 'Gray', 'Hygienist'),
  ('Bob', 'Adams', 'Assistant');

  INSERT INTO `procedure` (patient_id, procedure_date, procedure_type_id) VALUES
  (1, '2024-01-10', 1),
  (2, '2024-01-12', 3),
  (3, '2024-01-15', 2);

  INSERT INTO procedure_employee (procedure_id, employee_id) VALUES
  (1, 1),
  (1, 3),
  (2, 2),
  (3, 1);

  INSERT INTO procedure_inventory (procedure_id, product_id, quantity_used) VALUES
  (1, 1, 1),
  (2, 3, 1),
  (3, 2, 1);

  COMMIT;

  SET FOREIGN_KEY_CHECKS = 1;
END//

DELIMITER ;