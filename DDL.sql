

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
);

-- junction: procedure <-> employee
CREATE TABLE procedure_employee (
    procedure_id INT NOT NULL,
    employee_id INT NOT NULL,
    PRIMARY KEY (procedure_id, employee_id),
    FOREIGN KEY (procedure_id) REFERENCES `procedure`(procedure_id)
    ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
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
);
