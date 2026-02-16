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

-- SELECT: get all patients
    SELECT * FROM patient;

-- SELECT: get a single patient by patient_id
    SELECT * FROM patient WHERE patient_id = @patient_id_Input;

-- INSERT: add new patient
    INSERT INTO patient (
        first_name,
        last_name,
        email,
        phone
    ) VALUES (
        @first_name_Input,
        @last_name_Input,
        @email_Input,
        @phone_Input
    );

-- UPDATE: Update an existing patient by patient_id
    UPDATE patient
    SET 
        first_name = @first_name_Update,
        last_name = @last_name_Update,
        email = @email_Update,
        phone = @phone_Update
    WHERE patient_id = @patient_id_Update;

-- DELETE: Delete a patient by patient_id
    DELETE FROM patient
    WHERE patient_id = @patient_id_Delete;


-- SELECT: get all employees
    SELECT * FROM employee;

-- SELECT: get a single employee by employee_id
    SELECT * FROM employee WHERE employee_id = @employee_id_Input;

-- INSERT: add new employee
    INSERT INTO employee (
        first_name,
        last_name,
        role
    ) VALUES (
        @first_name_Input,
        @last_name_Input,
        @role_Input
    );

-- UPDATE: Update an existing employee by employee_id
    UPDATE employee
    SET 
        first_name = @first_name_Update,
        last_name = @last_name_Update,
        role = @role_Update
    WHERE employee_id = @employee_id_Update;

-- DELETE: Delete a employee by employee_id
    DELETE FROM employee
    WHERE employee_id = @employee_id_Delete;

-- SELECT: get all inventory
    SELECT * FROM inventory;

-- SELECT: get a single inventory by inventory_id
    SELECT * FROM inventory WHERE product_id = @product_id_Input;

-- INSERT: add new inventory
    INSERT INTO inventory (
        product_name,
        unit_cost
    ) VALUES (
        @product_name_Input,
        @unit_cost_Input
    );

-- UPDATE: Update an existing inventory item by product_id
    UPDATE inventory
    SET 
        product_name = @product_name_Update,
        unit_cost = @unit_cost_Update,
    WHERE product_id = @product_id_Update;

-- DELETE: Delete a product by product_id
    DELETE FROM inventory
    WHERE product_id = @product_id_Delete;

-- SELECT: get all procedure
    SELECT * FROM `procedure`;

-- SELECT: get a single procedure by procedure_id
    SELECT * FROM `procedure` WHERE procedure_id = @procedure_id_Input;

-- INSERT: add new procedure
    INSERT INTO `procedure` (
        patient_id,
        procedure_date,
        procedure_type_id
    ) VALUES (
        @patient_id_Input,
        @procedure_date_Input,
        @procedure_type_Input
    );

-- UPDATE: Update an existing procedure item by procedure_id
    UPDATE `procedure`
    SET 
        patient_id = @patient_id_Update,
        procedure_date = @procedure_date_Update,
        procedure_type_id = @procedure_type_id
    WHERE procedure_id = @procedure_id_Update;

-- DELETE: Delete a procedure by procedure_id
    DELETE FROM `procedure`
    WHERE procedure_id = @procedure_id_Delete;

-- SELECT: get all procedure_types
    SELECT * FROM procedure_type;

-- SELECT: get a single procedure_type by procedure_type_id
    SELECT * FROM procedure_type WHERE procedure_type_id = @procedure_type_id_Input;

-- INSERT: add new procedure type
    INSERT INTO procedure_type (
        name,
        description
    ) VALUES (
        @name_Input,
        @description_Input
    );

-- UPDATE: Update an existing procedure_type by procedure_type_id
    UPDATE procedure_type
    SET 
        name = @name_Update,
        description = @description_Update
    WHERE procedure_type_id = @procedure_type_id_Update;

-- DELETE: Delete a procedure_type by procedure_type_id
    DELETE FROM procedure_type
    WHERE procedure_type_id = @procedure_type_id_Delete;

-- SELECT: get all procedure inventory
    SELECT * FROM procedure_inventory;

-- SELECT: get all procedures from procedure_inventory that uses a specific procedure
    SELECT * FROM procedure_inventory WHERE procedure_id = @procedure_id_Input;

-- SELECT: get all procdeures from  procedure_inventory that uses a specific product
    SELECT * FROM procedure_inventory WHERE product_id = @product_id_Input;

-- SELECT: get a single procedure_inventory record
    SELECT * FROM procedure_inventory WHERE procedure_id = @procedure_id_Input AND product_id = @product_id_Input;

-- INSERT: add a new entry to procedure_inventory
    INSERT INTO procedure_inventory (
        procedure_id,
        product_id,
        quantity_used
    ) VALUES (
        @procedure_id_Input,
        @product_id_Input,
        @quantity_used_Input
    );

-- UPDATE: Update an existing entry to procedure_inventory
    UPDATE procedure_inventory
    SET 
        quantity_used = @quantity_used_Update,
    WHERE procedure_id = @procedure_id_Update AND product_id = @product_id_Update;

-- DELETE: Delete a procedure_inventory by procedure and product ids
    DELETE FROM procedure_inventory
    WHERE procedure_id = @procedure_id_Delete AND product_id = @product_id_Delete;

-- SELECT: get all procedure employees
    SELECT * FROM procedure_employee;

-- SELECT: get all entries from procedure_employee that uses a specific procedure
    SELECT * FROM procedure_employee WHERE procedure_id = @procedure_id_Input;

-- SELECT: get all entries from procedure_employee assigned to a specific employee
    SELECT * FROM procedure_employee WHERE employee_id = @employee_id_Input;

-- SELECT: get a specific procedure_employee record
    SELECT * FROM procedure_employee WHERE procedure_id = @procedure_id_Input AND employee_id = @employee_id_Input; 

-- INSERT: add a new entry to precedure_employee
    INSERT INTO procedure_employee (
        procedure_id,
        employee_id
    ) VALUES (
        @procedure_id_Input,
        @employee_id_Input
    );

-- DELETE: Delete a procedure_employee entry by procedure and product ids
    DELETE FROM procedure_employee
    WHERE procedure_id = @procedure_id_Delete AND employee_id = @product_id_Delete;