
-- QUERY 1: VIEW ALL STUDENTS
-- Shows all students in the database.


SELECT * FROM students;



-- QUERY 2: UNPAID, PARTIALLY PAID AND OVERDUE INVOICES
-- Shows fees that still require payment.


SELECT
    i.invoice_id,
    s.student_number,
    s.full_name,
    f.fee_name,
    i.amount,
    i.status
FROM invoices i
JOIN students s
    ON s.student_id = i.student_id
JOIN fee_types f
    ON f.fee_type_id = i.fee_type_id
WHERE i.status IN ('Unpaid', 'Partially Paid', 'Overdue')
ORDER BY i.due_date;



-- QUERY 3: PAYMENT HISTORY
-- Shows all payments made by students.


SELECT
    s.full_name,
    i.invoice_id,
    f.fee_name,
    p.payment_date,
    p.amount,
    p.payment_method,
    p.reference
FROM payments p
JOIN invoices i
    ON i.invoice_id = p.invoice_id
JOIN students s
    ON s.student_id = i.student_id
JOIN fee_types f
    ON f.fee_type_id = i.fee_type_id
ORDER BY p.payment_date;



-- QUERY 4: TOTAL COLLECTIONS
-- Calculates the total amount collected.


SELECT
    COALESCE(SUM(amount), 0) AS total_collections
FROM payments;



-- QUERY 5: COLLECTIONS BY PAYMENT METHOD
-- Shows how much was collected through each payment method.


SELECT
    payment_method,
    SUM(amount) AS total_collected
FROM payments
GROUP BY payment_method
ORDER BY total_collected DESC;



-- QUERY 6: OVERDUE INVOICES
-- Finds invoices past their due date that are not fully paid.


SELECT
    i.invoice_id,
    s.student_number,
    s.full_name,
    f.fee_name,
    i.due_date,
    i.amount,
    i.status
FROM invoices i
JOIN students s
    ON s.student_id = i.student_id
JOIN fee_types f
    ON f.fee_type_id = i.fee_type_id
WHERE i.due_date < CURRENT_DATE
  AND i.status IN ('Unpaid', 'Partially Paid', 'Overdue')
ORDER BY i.due_date;



-- QUERY 7: OUTSTANDING BALANCE PER INVOICE
-- Calculates the remaining balance on each invoice.

SELECT
    i.invoice_id,
    s.student_number,
    s.full_name,
    f.fee_name,
    i.amount AS invoice_amount,
    COALESCE(SUM(p.amount), 0) AS amount_paid,
    i.amount - COALESCE(SUM(p.amount), 0) AS outstanding_balance,
    i.status
FROM invoices i
JOIN students s
    ON s.student_id = i.student_id
JOIN fee_types f
    ON f.fee_type_id = i.fee_type_id
LEFT JOIN payments p
    ON p.invoice_id = i.invoice_id
GROUP BY
    i.invoice_id,
    s.student_number,
    s.full_name,
    f.fee_name,
    i.amount,
    i.status
HAVING i.amount - COALESCE(SUM(p.amount), 0) > 0
ORDER BY outstanding_balance DESC;



-- QUERY 8: OUTSTANDING BALANCE PER STUDENT
-- Calculates the total amount each student still owes.


SELECT
    s.student_number,
    s.full_name,
    COUNT(i.invoice_id) AS outstanding_invoices,
    ROUND(
        SUM(
            i.amount
            * (1 - COALESCE(d.percentage, 0) / 100)
            - COALESCE(paid.total_paid, 0)
        ),
        2
    ) AS outstanding_balance
FROM students s
JOIN invoices i
    ON i.student_id = s.student_id
LEFT JOIN discounts d
    ON d.discount_id = i.discount_id
LEFT JOIN (
    SELECT
        invoice_id,
        SUM(amount) AS total_paid
    FROM payments
    GROUP BY invoice_id
) paid
    ON paid.invoice_id = i.invoice_id
WHERE i.status <> 'Cancelled'
GROUP BY
    s.student_id,
    s.student_number,
    s.full_name
HAVING SUM(
    i.amount
    * (1 - COALESCE(d.percentage, 0) / 100)
    - COALESCE(paid.total_paid, 0)
) > 0
ORDER BY outstanding_balance DESC;



-- QUERY 9: COLLECTIONS BY FEE TYPE
-- Shows how much has been collected for each type of fee.


SELECT
    f.fee_name,
    COALESCE(SUM(p.amount), 0) AS total_collected
FROM fee_types f
LEFT JOIN invoices i
    ON i.fee_type_id = f.fee_type_id
LEFT JOIN payments p
    ON p.invoice_id = i.invoice_id
GROUP BY
    f.fee_type_id,
    f.fee_name
ORDER BY total_collected DESC;



-- QUERY 10: STUDENTS WITH OVERDUE BALANCES
-- Shows students who have overdue invoices.


SELECT
    s.student_number,
    s.full_name,
    COUNT(i.invoice_id) AS overdue_invoices
FROM students s
JOIN invoices i
    ON i.student_id = s.student_id
WHERE i.due_date < CURRENT_DATE
  AND i.status IN ('Unpaid', 'Partially Paid', 'Overdue')
GROUP BY
    s.student_id,
    s.student_number,
    s.full_name
ORDER BY overdue_invoices DESC;