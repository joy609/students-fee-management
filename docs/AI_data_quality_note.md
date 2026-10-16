# AI and Data Quality Note

## 1. Introduction

Artificial Intelligence (AI) can be used alongside database systems to help identify patterns, inconsistencies, and potential data-quality problems.

For a student fee management system, AI can assist administrators by analysing invoices, payments, student records, and outstanding balances.

AI should support human decision-making rather than automatically changing financial records without verification.

---

## 2. Data Quality Issues Identified

The sample database contains a potential inconsistency between invoice status and payment records.

### Invoice 1

- Invoice amount: ₦250,000
- Amount paid: ₦225,000
- Outstanding balance: ₦25,000
- Invoice status: Paid

The invoice is marked as "Paid", but the payment records show that ₦25,000 is still outstanding.

### Invoice 9

- Invoice amount: ₦250,000
- Amount paid: ₦225,000
- Outstanding balance: ₦25,000
- Invoice status: Paid

This invoice also has an outstanding balance even though its status is recorded as "Paid".

---

## 3. Why This Matters

Incorrect payment statuses can affect financial reporting and management decisions.

For example:

- The amount actually collected may be overstated.
- Outstanding balances may be underestimated.
- Students may incorrectly appear to have completed their payments.
- Financial reports may contain inconsistent information.

---

## 4. How SQL Can Detect the Problem

A SQL query can compare the invoice amount with the total payments recorded against each invoice.

For example:

```sql
SELECT
    i.invoice_id,
    i.amount AS invoice_amount,
    COALESCE(SUM(p.amount), 0) AS amount_paid,
    i.amount - COALESCE(SUM(p.amount), 0) AS outstanding_balance,
    i.status
FROM invoices i
LEFT JOIN payments p
    ON p.invoice_id = i.invoice_id
GROUP BY
    i.invoice_id,
    i.amount,
    i.status
HAVING i.amount - COALESCE(SUM(p.amount), 0) > 0;