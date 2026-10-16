-- Remove existing tables if they exist.
-- CASCADE removes dependent foreign-key objects.
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS discounts CASCADE;
DROP TABLE IF EXISTS fee_types CASCADE;
DROP TABLE IF EXISTS students CASCADE;



-- 1. STUDENTS
-- Stores information about each student.


CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_number VARCHAR(20) NOT NULL UNIQUE,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20),
    enrollment_date DATE NOT NULL
);


-- 2. FEE TYPES
-- Stores the different types of fees students may owe.


CREATE TABLE fee_types (
    fee_type_id SERIAL PRIMARY KEY,
    fee_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    standard_amount NUMERIC(12,2) NOT NULL CHECK (standard_amount >= 0)
);


=
-- 3. DISCOUNTS
-- Stores available student-fee discounts.


CREATE TABLE discounts (
    discount_id SERIAL PRIMARY KEY,
    discount_name VARCHAR(100) NOT NULL UNIQUE,
    percentage NUMERIC(5,2) NOT NULL
        CHECK (percentage >= 0 AND percentage <= 100)
);



-- 4. INVOICES
-- Stores fees billed to students.


CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY,

    student_id INTEGER NOT NULL
        REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    fee_type_id INTEGER NOT NULL
        REFERENCES fee_types(fee_type_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    invoice_date DATE NOT NULL,
    due_date DATE NOT NULL,

    amount NUMERIC(12,2) NOT NULL
        CHECK (amount >= 0),

    discount_id INTEGER
        REFERENCES discounts(discount_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    status VARCHAR(20) NOT NULL
        CHECK (status IN (
            'Unpaid',
            'Partially Paid',
            'Paid',
            'Overdue'
        )),

    CHECK (due_date >= invoice_date)
);



-- 5. PAYMENTS
-- Stores payments made against invoices.


CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,

    invoice_id INTEGER NOT NULL
        REFERENCES invoices(invoice_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    payment_date DATE NOT NULL,

    amount NUMERIC(12,2) NOT NULL
        CHECK (amount > 0),

    payment_method VARCHAR(30) NOT NULL
        CHECK (payment_method IN (
            'Bank Transfer',
            'Card',
            'Cash',
            'Mobile Money'
        )),

    reference VARCHAR(50) NOT NULL UNIQUE
);



-- INDEXES
-- Improve performance when searching and joining tables.


CREATE INDEX idx_invoices_student_id
    ON invoices(student_id);

CREATE INDEX idx_invoices_fee_type_id
    ON invoices(fee_type_id);

CREATE INDEX idx_invoices_due_date
    ON invoices(due_date);

CREATE INDEX idx_invoices_status
    ON invoices(status);

CREATE INDEX idx_payments_invoice_id
    ON payments(invoice_id);

CREATE INDEX idx_payments_payment_date
    ON payments(payment_date);