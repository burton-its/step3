DELIMITER //

-- PATIENT PROCEDURES
DROP PROCEDURE IF EXISTS sp_add_patient//
CREATE PROCEDURE sp_add_patient(
    IN p_first_name VARCHAR(255),
    IN p_last_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_phone VARCHAR(50)
)
BEGIN
    INSERT INTO patient (first_name, last_name, email, phone)
    VALUES (p_first_name, p_last_name, p_email, p_phone);
END//

DROP PROCEDURE IF EXISTS sp_update_patient//
CREATE PROCEDURE sp_update_patient(
    IN p_patient_id INT,
    IN p_first_name VARCHAR(255),
    IN p_last_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_phone VARCHAR(50)
)
BEGIN
    UPDATE patient 
    SET first_name = p_first_name,
        last_name = p_last_name,
        email = p_email,
        phone = p_phone
    WHERE patient_id = p_patient_id;
END//

DROP PROCEDURE IF EXISTS sp_delete_patient//
CREATE PROCEDURE sp_delete_patient(
    IN p_patient_id INT
)
BEGIN
    DELETE FROM patient
    WHERE patient_id = p_patient_id;
END//

-- EMPLOYEE PROCEDURES
DROP PROCEDURE IF EXISTS sp_add_employee//
CREATE PROCEDURE sp_add_employee(
    IN e_first_name VARCHAR(255),
    IN e_last_name VARCHAR(255),
    IN e_role VARCHAR(255)
)
BEGIN
    INSERT INTO employee (first_name, last_name, `role`)
    VALUES (e_first_name, e_last_name, e_role);
END//

DROP PROCEDURE IF EXISTS sp_update_employee//
CREATE PROCEDURE sp_update_employee(
    IN e_employee_id INT,
    IN e_first_name VARCHAR(255),
    IN e_last_name VARCHAR(255),
    IN e_role VARCHAR(255)
)
BEGIN
    UPDATE employee 
    SET first_name = e_first_name,
        last_name = e_last_name,
        `role` = e_role
    WHERE employee_id = e_employee_id;
END//

DROP PROCEDURE IF EXISTS sp_delete_employee//
CREATE PROCEDURE sp_delete_employee(
    IN e_employee_id INT
)
BEGIN
    DELETE FROM employee
    WHERE employee_id = e_employee_id;
END//

-- INVENTORY PROCEDURES
DROP PROCEDURE IF EXISTS sp_add_inventory//
CREATE PROCEDURE sp_add_inventory(
    IN i_product_name VARCHAR(255),
    IN i_unit_cost DECIMAL(10,2)
)
BEGIN
    INSERT INTO inventory (product_name, unit_cost)
    VALUES (i_product_name, i_unit_cost);
END//

DROP PROCEDURE IF EXISTS sp_update_inventory//
CREATE PROCEDURE sp_update_inventory(
    IN i_product_id INT,
    IN i_product_name VARCHAR(255),
    IN i_unit_cost DECIMAL(10,2)
)
BEGIN
    UPDATE inventory 
    SET product_name = i_product_name,
        unit_cost = i_unit_cost
    WHERE product_id = i_product_id;
END//

DROP PROCEDURE IF EXISTS sp_delete_inventory//
CREATE PROCEDURE sp_delete_inventory(
    IN i_product_id INT
)
BEGIN
    DELETE FROM inventory
    WHERE product_id = i_product_id;
END//

-- PROCEDURE PROCEDURES
DROP PROCEDURE IF EXISTS sp_add_procedure//
CREATE PROCEDURE sp_add_procedure(
    IN pr_patient_id INT,
    IN pr_procedure_date DATE,
    IN pr_procedure_type_id INT
)
BEGIN
    INSERT INTO `procedure` (patient_id, procedure_date, procedure_type_id)
    VALUES (pr_patient_id, pr_procedure_date, pr_procedure_type_id);
END//

DROP PROCEDURE IF EXISTS sp_update_procedure//
CREATE PROCEDURE sp_update_procedure(
    IN pr_procedure_id INT,
    IN pr_patient_id INT,
    IN pr_procedure_date DATE,
    IN pr_procedure_type_id INT
)
BEGIN
    UPDATE `procedure` 
    SET patient_id = pr_patient_id,
        procedure_date = pr_procedure_date,
        procedure_type_id = pr_procedure_type_id
    WHERE procedure_id = pr_procedure_id;
END//

DROP PROCEDURE IF EXISTS sp_delete_procedure//
CREATE PROCEDURE sp_delete_procedure(
    IN pr_procedure_id INT
)
BEGIN
    DELETE FROM `procedure`
    WHERE procedure_id = pr_procedure_id;
END//

-- PROCEDURE INVENTORY PROCEDURES
DROP PROCEDURE IF EXISTS sp_update_procedure_inventory//
CREATE PROCEDURE sp_update_procedure_inventory(
    IN pi_procedure_id INT,
    IN pi_product_id INT,
    IN pi_quantity_used INT
)
BEGIN
    UPDATE procedure_inventory
    SET quantity_used = pi_quantity_used
    WHERE procedure_id = pi_procedure_id AND product_id = pi_product_id;
END//

-- PROCEDURE EMPLOYEE PROCEDURES
DROP PROCEDURE IF EXISTS sp_update_procedure_employee//
CREATE PROCEDURE sp_update_procedure_employee(
    IN pe_cur_procedure_id INT,
    IN pe_cur_employee_id INT,
    IN pe_new_procedure_id INT,
    IN pe_new_employee_id INT
)
BEGIN  
    UPDATE procedure_employee
    SET procedure_id = pe_new_procedure_id,
        employee_id = pe_new_employee_id
    WHERE procedure_id = pe_cur_procedure_id AND employee_id = pe_cur_employee_id;
END//

DELIMITER ;