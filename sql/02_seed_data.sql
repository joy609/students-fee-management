


-- 1. STUDENTS
INSERT INTO students
    (student_number, full_name, email, phone, enrollment_date)
VALUES
    ('STU001', 'Amaka Okafor', 'amaka@example.com', '08031234567', '2026-01-10'),
    ('STU002', 'David Mensah', 'david@example.com', '08141234567', '2026-01-10'),
    ('STU003', 'Blessing Adeyemi', 'blessing@example.com', '07051234567', '2026-01-12'),
    ('STU004', 'Chinedu Obi', 'chinedu@example.com', '09061234567', '2026-01-15'),
    ('STU005', 'Sarah Ibrahim', 'sarah@example.com', '08071234567', '2026-01-18'),
    ('STU006', 'Tolu Williams', 'tolu@example.com', '08181234567', '2026-02-01'),
    ('STU007', 'Mariam Yusuf', 'mariam@example.com', '07091234567', '2026-02-03'),
    ('STU008', 'Emeka Nwosu', 'emeka@example.com', '08101234567', '2026-02-05');


-- 2. FEE TYPES
INSERT INTO fee_types
    (fee_name, description, standard_amount)
VALUES
    ('Tuition', 'Main academic tuition fee', 250000),
    ('Registration', 'New student registration fee', 25000),
    ('Technology Fee', 'Technology and learning platform fee', 30000),
    ('Library Fee', 'Library resources fee', 15000),
    ('Laboratory Fee', 'Laboratory resources fee', 40000);


-- 3. DISCOUNTS
INSERT INTO discounts
    (discount_name, percentage)
VALUES
    ('No Discount', 0),
    ('Scholarship 10%', 10),
    ('Scholarship 20%', 20),
    ('Early Payment 5%', 5);


-- 4. INVOICES
INSERT INTO invoices
    (student_id, fee_type_id, invoice_date, due_date, amount, discount_id, status)
VALUES
    (1, 1, '2026-01-10', '2026-02-10', 250000, 2, 'Paid'),
    (1, 2, '2026-01-10', '2026-02-10', 25000, 1, 'Paid'),
    (2, 1, '2026-01-11', '2026-02-11', 250000, 3, 'Partially Paid'),
    (2, 3, '2026-01-11', '2026-02-11', 30000, 1, 'Paid'),
    (3, 1, '2026-01-12', '2026-02-12', 250000, 1, 'Overdue'),
    (3, 4, '2026-01-12', '2026-02-12', 15000, 1, 'Paid'),
    (4, 1, '2026-01-15', '2026-02-15', 250000, 4, 'Unpaid'),
    (4, 5, '2026-01-15', '2026-02-15', 40000, 1, 'Paid'),
    (5, 1, '2026-01-18', '2026-02-18', 250000, 2, 'Paid'),
    (5, 3, '2026-01-18', '2026-02-18', 30000, 1, 'Overdue'),
    (6, 1, '2026-02-01', '2026-03-01', 250000, 1, 'Paid'),
    (7, 1, '2026-02-03', '2026-03-03', 250000, 3, 'Partially Paid'),
    (8, 2, '2026-02-05', '2026-03-05', 25000, 1, 'Overdue');


-- 5. PAYMENTS
INSERT INTO payments
    (invoice_id, payment_date, amount, payment_method, reference)
VALUES
    (1, '2026-02-05', 225000, 'Bank Transfer', 'PAY001'),
    (2, '2026-02-05', 25000, 'Card', 'PAY002'),
    (3, '2026-02-10', 100000, 'Bank Transfer', 'PAY003'),
    (4, '2026-02-09', 30000, 'Card', 'PAY004'),
    (6, '2026-02-10', 15000, 'Cash', 'PAY005'),
    (8, '2026-02-14', 40000, 'Bank Transfer', 'PAY006'),
    (9, '2026-02-15', 225000, 'Bank Transfer', 'PAY007'),
    (11, '2026-02-25', 250000, 'Mobile Money', 'PAY008'),
    (12, '2026-02-28', 100000, 'Bank Transfer', 'PAY009');