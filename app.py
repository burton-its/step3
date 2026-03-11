from flask import Flask, render_template, json, redirect, request, url_for, abort
from flask_mysqldb import MySQL
import os
import MySQLdb.cursors

app = Flask(__name__)
app.config.from_pyfile(os.path.join(os.path.dirname(__file__), "config.py"))
mysql = MySQL(app)

@app.context_processor
def inject_dev_flags():
    return {
        "allow_db_reset": os.getenv("ALLOW_DB_RESET", "false").lower() == "true"
    }

# Routes
@app.route('/')
def root():
    return render_template('index.html')


@app.post("/admin/reset-db")
def reset_db():
    if os.getenv("ALLOW_DB_RESET", "false").lower() != "true":
        abort(403)

    if request.headers.get("X-Admin-Token", "") != os.getenv("ADMIN_TOKEN", ""):
        abort(401)

    cur = mysql.connection.cursor()
    try:
        cur.execute("CALL sp_reset_db();")
        cur.nextset()
        mysql.connection.commit()
        return {"ok": True}, 200
    except Exception as e:
        mysql.connection.rollback()
        return {"ok": False, "error": str(e)}, 500
    finally:
        cur.close()


@app.route('/home')
def home():
    return render_template('index.html')

@app.route('/browse_patients')
def browse_patients():
    cur = mysql.connection.cursor()

    query1 = 'SELECT * FROM patient;'

    cur.execute(query1)
    patients = cur.fetchall()

    cur.close()
    return render_template('browse_patients.html', patients=patients)

# add patient
@app.route('/patients/add', methods=['GET', 'POST'])
def add_patient():
    if request.method == 'POST':
        first = request.form['first_name']
        last  = request.form['last_name']
        email = request.form['email']
        phone = request.form['phone']

        cur = mysql.connection.cursor()
        cur.execute(
            """
            CALL sp_add_patient(%s, %s, %s, %s)
            """,
            (first, last, email, phone)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect('/browse_patients')

    return render_template('add_patient.html')

# edit patient
@app.route('/patients/edit/<int:patient_id>', methods=['GET', 'POST'])
def edit_patient(patient_id):
    cur = mysql.connection.cursor()

    if request.method == 'POST':
        first = request.form['first_name']
        last  = request.form['last_name']
        email = request.form['email']
        phone = request.form['phone']

        cur.execute(
            """
            CALL sp_update_patient(%s, %s, %s, %s, %s)
            """,
            (patient_id, first, last, email, phone)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect('/browse_patients')

    # GET: get *
    cur.execute("SELECT * FROM patient WHERE patient_id=%s", (patient_id,))
    patient = cur.fetchone()
    cur.close()
    return render_template('edit_patient.html', patient=patient)


# delete patient
@app.route('/patients/delete/<int:patient_id>', methods=['POST'])
def delete_patient(patient_id):
    cur = mysql.connection.cursor()
    cur.execute("CALL sp_delete_patient(%s)", (patient_id,))
    cur.nextset()
    mysql.connection.commit()
    cur.close()
    return redirect('/browse_patients')

# browse employee
@app.route('/browse_employees')
def browse_employees():
    cur = mysql.connection.cursor()

    query2 = 'SELECT * FROM employee;'

    cur.execute(query2)
    employees = cur.fetchall()

    cur.close()
    return render_template('browse_employees.html', employees=employees)

# add employee
@app.route('/employees/add', methods=['GET', 'POST'])
def add_employee():
    if request.method == 'POST':
        first = request.form['first_name']
        last  = request.form['last_name']
        role = request.form['role']

        cur = mysql.connection.cursor()
        cur.execute(
            """
            CALL sp_add_employee(%s, %s, %s)
            """,
            (first, last, role)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect('/browse_employees')

    return render_template('add_employee.html')

# edit employee
@app.route('/employees/edit/<int:employee_id>', methods=['GET', 'POST'])
def edit_employee(employee_id):
    cur = mysql.connection.cursor()

    if request.method == 'POST':
        first = request.form['first_name']
        last  = request.form['last_name']
        role = request.form['role']

        cur.execute(
            """
            CALL sp_update_employee(%s, %s, %s, %s)
            """,
            (employee_id, first, last, role)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect('/browse_employees')

    # GET: get *
    cur.execute("SELECT * FROM employee WHERE employee_id=%s", (employee_id,))
    employee = cur.fetchone()
    cur.close()
    return render_template('edit_employee.html', employee=employee)

# delete employee
@app.route('/employees/delete/<int:employee_id>', methods=['POST'])
def delete_employee(employee_id):
    cur = mysql.connection.cursor()
    cur.execute("CALL sp_delete_employee(%s)", (employee_id,))
    cur.nextset()
    mysql.connection.commit()
    cur.close()
    return redirect('/browse_employees')

#browse inventory
@app.route('/browse_inventory')
def browse_inventory():
    cur = mysql.connection.cursor()

    query3 = 'SELECT * FROM inventory;'

    cur.execute(query3)
    inventories = cur.fetchall()

    cur.close()
    return render_template('browse_inventory.html', inventories=inventories)

# add inventory
@app.route('/inventory/add', methods=['GET', 'POST'])
def add_inventory():
    if request.method == 'POST':
        name = request.form['product_name']
        unit_cost  = request.form['unit_cost']

        cur = mysql.connection.cursor()
        cur.execute(
            """
            CALL sp_add_inventory(%s, %s)
            """,
            (name, unit_cost)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect('/browse_inventory')

    return render_template('add_inventory.html')

# edit inventory
@app.route('/inventory/edit/<int:product_id>', methods=['GET', 'POST'])
def edit_inventory(product_id):
    cur = mysql.connection.cursor()

    if request.method == 'POST':
        name = request.form['product_name']
        unit_cost  = request.form['unit_cost']

        cur.execute(
            """
            CALL sp_update_inventory(%s, %s, %s)
            """,
            (product_id, name, unit_cost)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect('/browse_inventory')

    # GET: get *
    cur.execute("SELECT * FROM inventory WHERE product_id=%s", (product_id,))
    inventory = cur.fetchone()
    cur.close()
    return render_template('edit_inventory.html', inventory=inventory)

# delete inventory
@app.route('/inventory/delete/<int:product_id>', methods=['POST'])
def delete_inventory(product_id):
    cur = mysql.connection.cursor()
    try:
        cur.execute("CALL sp_delete_inventory(%s)", (product_id,))
        cur.nextset()
        mysql.connection.commit()
    except Exception as e:
        mysql.connection.rollback()
        print("Delete inventory error:", e)
        return "Cannot delete product because it is referenced by another record."
    finally:
        cur.close()

    return redirect('/browse_inventory')

# browse procedures
@app.route('/browse_procedures')
def browse_procedures():
    cur = mysql.connection.cursor()

    query4 = '''
    SELECT 
        `procedure`.procedure_id,
        CONCAT(patient.first_name, ' ', patient.last_name) AS patient_name,
        procedure_type.name AS procedure_type_name,
        `procedure`.procedure_date
    FROM `procedure`
    JOIN patient ON `procedure`.patient_id = patient.patient_id
    JOIN procedure_type ON `procedure`.procedure_type_id = procedure_type.procedure_type_id;
    '''

    cur.execute(query4)
    procedures = cur.fetchall()

    cur.close()
    return render_template('browse_procedures.html', procedures=procedures)

# add procedure
@app.route('/procedures/add', methods=['GET', 'POST'])
def add_procedure():
    if request.method == 'POST':
        patient_id = request.form['patient_id']
        date  = request.form['procedure_date']
        procedure_type_id = request.form['procedure_type_id']

        cur = mysql.connection.cursor()
        cur.execute(
            """
            CALL sp_add_procedure(%s, %s, %s)
            """,
            (patient_id, date, procedure_type_id)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect('/browse_procedures')

    return render_template('add_procedure.html')

# edit procedure
@app.route('/procedures/edit/<int:procedure_id>', methods=['GET', 'POST'])
def edit_procedure(procedure_id):
    cur = mysql.connection.cursor()

    if request.method == 'POST':
        patient_id = request.form['patient_id']
        date  = request.form['procedure_date']
        procedure_type_id = request.form['procedure_type_id']

        cur.execute(
            """
            CALL sp_update_procedure(%s, %s, %s, %s)
            """,
            (procedure_id, patient_id, date, procedure_type_id)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect('/browse_procedures')

    # GET: get *
    cur.execute("SELECT * FROM `procedure` WHERE procedure_id=%s", (procedure_id,))
    procedure = cur.fetchone()
    cur.close()
    return render_template('edit_procedure.html', procedure=procedure)

# delete procedure
@app.route('/procedures/delete/<int:procedure_id>', methods=['POST'])
def delete_procedure(procedure_id):
    cur = mysql.connection.cursor()
    cur.execute("CALL sp_delete_procedure(%s)", (procedure_id,))
    cur.nextset()
    mysql.connection.commit()
    cur.close()
    return redirect('/browse_procedures')

# browse procedure types
@app.route('/browse_procedure_types')
def browse_procedure_types():
    cur = mysql.connection.cursor()

    query5 = 'SELECT * FROM procedure_type;'

    cur.execute(query5)
    procedure_types = cur.fetchall()

    cur.close()
    return render_template('browse_procedure_types.html', procedure_types=procedure_types)

# browse procedure inventory
@app.route('/browse_procedure_inventory')
def browse_procedure_inventory():
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    query6 = '''
    SELECT
        procedure_inventory.procedure_id,
        procedure_inventory.product_id,
        procedure_type.name AS procedure_type_name,
        inventory.product_name AS inventory_name,
        procedure_inventory.quantity_used
    FROM procedure_inventory
    JOIN `procedure` ON procedure_inventory.procedure_id = `procedure`.procedure_id
    JOIN procedure_type ON `procedure`.procedure_type_id = procedure_type.procedure_type_id
    JOIN inventory ON procedure_inventory.product_id = inventory.product_id;
    '''

    cur.execute(query6)
    procedure_inventories = cur.fetchall()
    cur.close()
    return render_template("browse_procedure_inventory.html",
                           procedure_inventories=procedure_inventories)

# edit procedure inventory
@app.route('/procedure_inventory/edit/<int:procedure_id>/<int:product_id>', methods=['GET', 'POST'])
def edit_procedure_inventory(procedure_id, product_id):
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    if request.method == 'POST':
        quantity_used = request.form["quantity_used"]
        cur.execute(
            "CALL sp_update_procedure_inventory(%s, %s, %s)", 
            (procedure_id, product_id, quantity_used)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('browse_procedure_inventory'))

    # GET: load current values
    cur.execute("""
        SELECT procedure_inventory.procedure_id,
               procedure_inventory.product_id,
               procedure_inventory.quantity_used,
               procedure_type.name AS procedure_type_name,
               inventory.product_name AS inventory_name
        FROM procedure_inventory
        JOIN `procedure` ON procedure_inventory.procedure_id = `procedure`.procedure_id
        JOIN procedure_type ON `procedure`.procedure_type_id = procedure_type.procedure_type_id
        JOIN inventory ON procedure_inventory.product_id = inventory.product_id
        WHERE procedure_inventory.procedure_id = %s
          AND procedure_inventory.product_id = %s
    """, (procedure_id, product_id))
    row = cur.fetchone()
    cur.close()
    return render_template("edit_procedure_inventory.html", row=row)

# browse procedure employees
@app.route('/browse_procedure_employees')
def browse_procedure_employees():
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    query7 = '''
    SELECT
        procedure_employee.procedure_id,
        procedure_employee.employee_id,
        procedure_type.name AS procedure_type_name,
        CONCAT(employee.first_name, ' ', employee.last_name) AS employee_name
    FROM procedure_employee
    JOIN `procedure` ON procedure_employee.procedure_id = `procedure`.procedure_id
    JOIN procedure_type ON procedure.procedure_type_id = procedure_type.procedure_type_id
    JOIN employee ON procedure_employee.employee_id = employee.employee_id;
    '''

    cur.execute(query7)
    procedure_employees = cur.fetchall()

    cur.close()
    return render_template('browse_procedure_employees.html', procedure_employees=procedure_employees)

# add procedure employee
@app.route('/procedure_employee/add', methods=['GET', 'POST'])
def add_procedure_employee():
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    if request.method == 'POST':
        procedure_id = request.form["procedure_id"]
        employee_id = request.form["employee_id"]

        cur.execute(
            """
            SELECT COUNT(*) AS cnt
            FROM procedure_employee
            WHERE procedure_id = %s AND employee_id = %s
            """, (procedure_id, employee_id))
        
        existing = cur.fetchone()

        if existing['cnt'] > 0:
            cur.close()
            return "Error: That employee is already assigned to this procedure."

        cur.execute(
            """
            CALL sp_add_procedure_employee(%s, %s)
            """,
            (procedure_id, employee_id)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect('/browse_procedure_employees')
    
    cur.execute(
        """
        SELECT `procedure`.procedure_id, procedure_type.name AS procedure_type_name
        FROM `procedure`
        JOIN procedure_type
        ON `procedure`.procedure_type_id = procedure_type.procedure_type_id
        """)
    procedures = cur.fetchall()

    cur.execute(
        """
        SELECT employee_id, CONCAT(first_name, ' ', last_name) AS employee_name
        FROM employee
        """)
    
    employees = cur.fetchall()

    cur.close()

    return render_template('add_procedure_employee.html', procedures=procedures, employees=employees)

# edit procedure employees
@app.route('/procedure_employee/edit/<int:procedure_id>/<int:employee_id>', methods=['GET', 'POST'])
def edit_procedure_employee(procedure_id, employee_id):
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    if request.method == 'POST':
        new_procedure_id = request.form["procedure_id"]
        new_employee_id = request.form["employee_id"]

        # Check if this combination already exists 
        cur.execute("""
            SELECT COUNT(*) AS cnt
            FROM procedure_employee
            WHERE procedure_id = %s AND employee_id = %s
        """, (new_procedure_id, new_employee_id))
        existing = cur.fetchone()
        if existing['cnt'] > 0 and (int(new_procedure_id) != procedure_id or int(new_employee_id) != employee_id):
            cur.close()
            return "Error: That employee is already assigned to this procedure!"

        # Safe to update
        cur.execute(
            "CALL sp_update_procedure_employee(%s, %s, %s, %s)",
            (procedure_id, employee_id, new_procedure_id, new_employee_id)
        )
        cur.nextset()
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('browse_procedure_employees'))

    # GET: load current row info
    cur.execute("""
        SELECT procedure_employee.procedure_id,
               procedure_employee.employee_id,
               procedure_type.name AS procedure_type_name,
               CONCAT(employee.first_name, ' ', employee.last_name) AS employee_name
        FROM procedure_employee
        JOIN `procedure` ON procedure_employee.procedure_id = `procedure`.procedure_id
        JOIN procedure_type ON `procedure`.procedure_type_id = procedure_type.procedure_type_id
        JOIN employee ON procedure_employee.employee_id = employee.employee_id
        WHERE procedure_employee.procedure_id = %s
          AND procedure_employee.employee_id = %s
    """, (procedure_id, employee_id))
    row = cur.fetchone()

    # Get all procedures for dropdown
    cur.execute("""
        SELECT `procedure`.procedure_id, procedure_type.name AS procedure_type_name
        FROM `procedure`
        JOIN procedure_type ON `procedure`.procedure_type_id = procedure_type.procedure_type_id
    """)
    procedures = cur.fetchall()

    # Get all employees for dropdown
    cur.execute("""
        SELECT employee_id, CONCAT(first_name, ' ', last_name) AS employee_name
        FROM employee
    """)
    employees = cur.fetchall()

    cur.close()
    return render_template("edit_procedure_employees.html",
                           row=row,
                           procedures=procedures,
                           employees=employees)

# delete procedure employee
@app.route('/procedure_employee/delete/<int:procedure_id>/<int:employee_id>', methods=['POST'])
def delete_procedure_employee(procedure_id, employee_id):
    cur = mysql.connection.cursor()
    cur.execute("CALL sp_delete_procedure_employee(%s, %s)", (procedure_id, employee_id))
    cur.nextset()
    mysql.connection.commit()
    cur.close()
    return redirect('/browse_procedure_employees')

# Listener
if __name__ == "__main__":

    #Start the app to run on a port of your choosing(change back to henry's)
    app.run(port=20251, debug=True)