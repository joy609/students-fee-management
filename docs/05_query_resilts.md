# Query Results and Evidence

This document summarizes the results produced by the 10 SQL queries used in the Student Fee Management Database project.

Screenshots of the executed queries and their results are stored in the `query_results` folder.

---

## Query 1: Student Records

Retrieves all student records from the `students` table.

**Result:** 8 students were returned.

---

## Query 2: Unpaid, Partially Paid, and Overdue Invoices

Identifies invoices whose status is Unpaid, Partially Paid, or Overdue.

**Result:** 6 invoices were identified.

---

## Query 3: Payment History

Displays payment history together with the student, invoice, fee type, payment date, amount, payment method, and payment reference.

**Result:** 9 payment records were returned.

---

## Query 4: Total Collections

Calculates the total amount collected from all recorded payments.

**Result:** ₦1,010,000 was collected.

---

## Query 5: Collections by Payment Method

Groups payments by payment method and calculates the total collected through each method.

**Payment methods include:**

- Bank Transfer
- Card
- Cash
- Mobile Money

---

## Query 6: Overdue Invoices

Identifies invoices that are past their due date and remain Unpaid, Partially Paid, or Overdue.

This helps management identify accounts requiring follow-up.

---

## Query 7: Outstanding Balance per Invoice

Calculates the amount paid and outstanding balance for each invoice.

This query helps identify invoices that still have unpaid amounts.

---

## Query 8: Outstanding Balance per Student

Groups outstanding invoices by student and calculates each student's total outstanding balance.

This provides a student-level view of unpaid fees.

---

## Query 9: Outstanding Balance by Fee Type

Groups outstanding balances by fee type.

This helps identify which categories of fees have the largest outstanding balances.

---

## Query 10: Overall Financial Summary

Provides a high-level summary of the database, including:

- Total number of students
- Total number of invoices
- Total amount invoiced
- Total amount collected
- Total outstanding balance

### Summary Results

| Metric | Result |
|---|---:|
| Total Students | 8 |
| Total Invoices | 13 |
| Total Invoiced | ₦1,915,000 |
| Total Collected | ₦1,010,000 |
| Total Outstanding | ₦905,000 |

---

## Evidence

The corresponding screenshots are stored in the `query_results` folder.

Each screenshot shows the SQL query executed in PostgreSQL using pgAdmin 4 and the resulting data.

These results demonstrate that the database, sample data, and SQL queries are functioning as expected.