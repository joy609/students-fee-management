


-- CHECK 1: Find duplicate student numbers
SELECT
    student_number,
    COUNT(*) AS duplicate_count
FROM students
GROUP BY student_number
HAVING COUNT(*) > 1;


-- CHECK 2: Find duplicate student emails
SELECT
    email,
    COUNT(*) AS duplicate_count
FROM students
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;


-- CHECK 3: Find invalid invoice amounts
SELECT
    invoice_id,
    amount
FROM invoices
WHERE amount <= 0;


-- CHECK 4: Find invalid payment amounts
SELECT
    payment_id,
    amount
FROM payments
WHERE amount <= 0;


-- CHECK 5: Find payments linked to non-existent invoices
SELECT
    p.payment_id,
    p.invoice_id
FROM payments p
LEFT JOIN invoices i
    ON i.invoice_id = p.invoice_id
WHERE i.invoice_id IS NULL;


-- CHECK 6: Find invoices where payments exceed the invoice amount
SELECT
    i.invoice_id,
    i.amount AS invoice_amount,
    COALESCE(SUM(p.amount), 0) AS amount_paid
FROM invoices i
LEFT JOIN payments p
    ON p.invoice_id = i.invoice_id
GROUP BY
    i.invoice_id,
    i.amount
HAVING COALESCE(SUM(p.amount), 0) > i.amount;


-- CHECK 7: Find invoices marked as Paid but still having
-- an outstanding balance
SELECT
    i.invoice_id,
    s.student_number,
    s.full_name,
    i.amount AS invoice_amount,
    COALESCE(SUM(p.amount), 0) AS amount_paid,
    i.amount - COALESCE(SUM(p.amount), 0) AS outstanding_balance,
    i.status
FROM invoices i
JOIN students s
    ON s.student_id = i.student_id
LEFT JOIN payments p
    ON p.invoice_id = i.invoice_id
WHERE i.status = 'Paid'
GROUP BY
    i.invoice_id,
    s.student_number,
    s.full_name,
    i.amount,
    i.status
HAVING i.amount - COALESCE(SUM(p.amount), 0) > 0;


-- CHECK 8: Find invoices with a due date before the invoice date
SELECT
    invoice_id,
    invoice_date,
    due_date
FROM invoices
WHERE due_date < invoice_date;


-- CHECK 9: Find students without an email address
SELECT
    student_id,
    student_number,
    full_name
FROM students
WHERE email IS NULL OR TRIM(email) = '';


-- CHECK 10: Compare total invoiced amount with total collected
SELECT
    (SELECT COALESCE(SUM(amount), 0) FROM invoices) AS total_invoiced,
    (SELECT COALESCE(SUM(amount), 0) FROM payments) AS total_collected,
    (
        (SELECT COALESCE(SUM(amount), 0) FROM invoices)
        -
        (SELECT COALESCE(SUM(amount), 0) FROM payments)
    ) AS difference;