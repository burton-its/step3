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