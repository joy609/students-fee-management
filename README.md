# Student Fee Management Database

## 1. Project Overview

This project is a PostgreSQL database designed to manage student fee records, invoices, payments, discounts, and outstanding balances.

The database demonstrates how relational database concepts can be used to support fee management and financial reporting in an educational institution.

---

## 2. Project Objectives

The main objectives of this project are to:

- Store student information.
- Store different types of school fees.
- Record available discounts.
- Generate and track student invoices.
- Record student payments.
- Calculate outstanding balances.
- Identify overdue and unpaid invoices.
- Analyse payment methods and collections.
- Perform data-quality checks.
- Demonstrate how AI can assist with identifying data-quality issues.

---

## 3. Database Technology

- Database Management System: PostgreSQL
- Database Administration Tool: pgAdmin 4
- SQL Development Environment: Visual Studio Code
- Programming Language: SQL

---

## 4. Database Tables

The database contains five main tables:

### Students

Stores student information such as:

- Student ID
- Student number
- Full name
- Email
- Phone number
- Enrollment date

### Fee Types

Stores the different types of fees charged to students.

Examples include:

- Tuition
- Registration
- Technology Fee
- Library Fee
- Laboratory Fee

### Discounts

Stores discount information and discount percentages.

### Invoices

Stores fees charged to students, including:

- Student
- Fee type
- Invoice date
- Due date
- Amount
- Discount
- Payment status

### Payments

Stores payments made against invoices, including:

- Invoice
- Payment date
- Amount
- Payment method
- Payment reference

---

## 5. Relationships

The main relationships are:

- One student can have many invoices.
- One fee type can appear on many invoices.
- One discount can be applied to many invoices.
- One invoice can have many payments.

Primary keys uniquely identify records, while foreign keys connect related tables.

---

## 6. SQL Queries

The project contains 10 SQL queries used to analyse the database.

The queries cover:

1. Student records
2. Unpaid, partially paid, and overdue invoices
3. Payment history
4. Total collections
5. Collections by payment method
6. Overdue invoices
7. Outstanding balance per invoice
8. Outstanding balance per student
9. Outstanding balance by fee type
10. Overall financial summary

---

## 7. Data Quality Checks

The project includes data-quality checks for:

- Duplicate student numbers
- Duplicate email addresses
- Invalid invoice amounts
- Invalid payment amounts
- Payments linked to missing invoices
- Payments exceeding invoice amounts
- Paid invoices with outstanding balances
- Invalid invoice dates
- Missing student email addresses
- Difference between total invoiced and total collected

---

## 8. Sample Database Results

The sample database contains:

- 8 students
- 13 invoices
- 9 payment records

The total amount collected from the sample payment records is:

**₦1,010,000**

The total invoiced amount is:

**₦1,915,000**

The calculated outstanding amount is:

**₦905,000**

---

## 9. AI and Data Quality

AI can assist with analysing database records and identifying potential data-quality problems.

For example, the sample database contains invoices marked as "Paid" where the recorded payment amount is less than the invoice amount.

This demonstrates how AI-assisted analysis can help identify inconsistencies that may require human review.

AI should support the database administrator rather than automatically changing financial records without verification.

---

## 10. Project Files

### SQL

- `01_schema.sql` - Creates the database tables and constraints.
- `02_seed_data.sql` - Inserts sample students, fees, discounts, invoices, and payments.
- `03_queries.sql` - Contains the 10 required analysis queries.
- `04_data_quality_checks.sql` - Contains data-quality validation queries.

### Data

- `03_sample_payment_records.csv` - Sample payment records.

---

## 11. How to Run the Project

1. Open PostgreSQL using pgAdmin 4.
2. Create a PostgreSQL database.
3. Open the Query Tool for the database.
4. Run `01_schema.sql` to create the tables.
5. Run `02_seed_data.sql` to insert the sample data.
6. Run individual queries from `03_queries.sql`.
7. Run `04_data_quality_checks.sql` to perform data-quality checks.

---

## 12. Conclusion

This project demonstrates the design and use of a relational database for student fee management.

It shows how PostgreSQL can be used to store structured financial information and how SQL queries can be used to generate useful management information such as collections, outstanding balances, overdue invoices, and payment history.