from flask import Flask, render_template, json, redirect
from flask_mysqldb import MySQL
from flask import request
import os

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'classmysql.engr.oregonstate.edu'
app.config['MYSQL_USER'] = 'cs340_kosterh'
app.config['MYSQL_PASSWORD'] = '2YamcmsG8fGv'
app.config['MYSQL_DB'] = 'cs340_kosterh'
app.config['MYSQL_CURSORCLASS'] = "DictCursor"


mysql = MySQL(app)

# Routes
@app.route('/')
def root():
    return render_template('index.html')

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

@app.route('/browse_employees')
def browse_employees():
    cur = mysql.connection.cursor()

    query2 = 'SELECT * FROM employee;'

    cur.execute(query2)
    employees = cur.fetchall()

    cur.close()
    return render_template('browse_employees.html', employees=employees)

@app.route('/browse_inventory')
def browse_inventory():
    cur = mysql.connection.cursor()

    query3 = 'SELECT * FROM inventory;'

    cur.execute(query3)
    inventories = cur.fetchall()

    cur.close()
    return render_template('browse_inventory.html', inventories=inventories)

@app.route('/browse_procedures')
def browse_procedures():
    cur = mysql.connection.cursor()

    query4 = 'SELECT * FROM `procedure`;'

    cur.execute(query4)
    procedures = cur.fetchall()

    cur.close()
    return render_template('browse_procedures.html', procedures=procedures)

@app.route('/browse_procedure_types')
def browse_procedure_types():
    cur = mysql.connection.cursor()

    query5 = 'SELECT * FROM procedure_type;'

    cur.execute(query5)
    procedure_types = cur.fetchall()

    cur.close()
    return render_template('browse_procedure_types.html', procedure_types=procedure_types)

@app.route('/browse_procedure_inventory')
def browse_procedure_inventory():
    cur = mysql.connection.cursor()

    query6 = 'SELECT * FROM procedure_inventory;'

    cur.execute(query6)
    procedure_inventories = cur.fetchall()

    cur.close()
    return render_template('browse_procedure_inventory.html', procedure_inventories=procedure_inventories)

@app.route('/browse_procedure_employees')
def browse_procedure_employees():
    cur = mysql.connection.cursor()

    query7 = 'SELECT * FROM procedure_employee;'

    cur.execute(query7)
    procedure_employees = cur.fetchall()

    cur.close()
    return render_template('browse_procedure_employees.html', procedure_employees=procedure_employees)


# Listener
if __name__ == "__main__":

    #Start the app to run on a port of your choosing
    app.run(port=3110, debug=True)