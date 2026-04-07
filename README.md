# 🦷 Dental Clinic Management System

A full-stack database web application for managing a dental clinic’s operations, including patients, employees, procedures, and inventory. This project was developed as part of a database systems course and demonstrates relational database design, stored procedures, and full CRUD (CUD) integration with a web interface.

## 🚀 Features
Manage Patients, Employees, Inventory, and Procedures
Handle many-to-many relationships via junction tables:
procedure_employee
procedure_inventory
Full Create, Update, Delete (CUD) functionality using stored procedures
Relational database design with foreign key constraints
Dynamic HTML tables for browsing data
Form-based UI for adding and editing records
Database reset endpoint for testing and grading
Error handling for:
Foreign key violations
Duplicate entries
Invalid input

## 🛠️ Tech Stack
Backend: Python, Flask
Database: MySQL
Frontend: HTML, Jinja Templates
Database Access: flask_mysqldb

## 🧠 Database Design

Key entities:

patient
employee
inventory
procedure
procedure_type

Junction tables:

procedure_employee (many-to-many)
procedure_inventory (many-to-many with quantity)

Highlights:

Primary keys on all tables
Composite keys on junction tables
Foreign key constraints enforce integrity
Cascading deletes used where appropriate

## 👨‍💻 Authors

Henry Koster
Computer Science Student – Oregon State University

Corey Burton 
Computer Science Student - Oregon State University

## 📌 Notes
Designed for educational use and demonstration of database concepts
Focused on correctness, relational integrity, and backend-driven UI
