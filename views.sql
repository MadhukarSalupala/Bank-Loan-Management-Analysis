USE bank_loan_project;


-- 1. Customer Loan Details
CREATE VIEW customer_loan_details AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    l.loan_id,
    l.loan_amount,
    l.loan_date,
    l.loan_status
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id;


-- 2. Loan Type Details
CREATE VIEW loan_type_details AS
SELECT
    l.loan_id,
    lt.loan_type_name,
    lt.interest_rate,
    l.loan_amount,
    l.loan_status
FROM loans l
JOIN loan_types lt
    ON l.loan_type_id = lt.loan_type_id;


-- 3. Branch Loan Details
CREATE VIEW branch_loan_details AS
SELECT
    b.branch_name,
    b.city,
    b.state,
    l.loan_id,
    l.loan_amount,
    l.loan_status
FROM branches b
JOIN loans l
    ON b.branch_id = l.branch_id;


-- 4. Approved Loans
CREATE VIEW approved_loans AS
SELECT
    loan_id,
    customer_id,
    loan_amount,
    loan_date,
    loan_status
FROM loans
WHERE loan_status = 'Approved';


-- 5. Loan Summary by Branch
CREATE VIEW branch_loan_summary AS
SELECT
    b.branch_name,
    COUNT(l.loan_id) AS total_loans,
    SUM(l.loan_amount) AS total_loan_amount
FROM branches b
JOIN loans l
    ON b.branch_id = l.branch_id
GROUP BY b.branch_name;


-- 6. Customer Loan Summary
CREATE VIEW customer_loan_summary AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(l.loan_id) AS total_loans,
    SUM(l.loan_amount) AS total_loan_amount
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


-- 7. Loan Payments Details
CREATE VIEW loan_payment_details AS
SELECT
    l.loan_id,
    l.loan_amount,
    lp.payment_date,
    lp.payment_amount,
    lp.payment_status
FROM loans l
JOIN loan_payments lp
    ON l.loan_id = lp.loan_id;


-- 8. Total Payments by Loan
CREATE VIEW loan_payment_summary AS
SELECT
    l.loan_id,
    l.loan_amount,
    COALESCE(SUM(lp.payment_amount), 0) AS total_payment
FROM loans l
LEFT JOIN loan_payments lp
    ON l.loan_id = lp.loan_id
GROUP BY l.loan_id, l.loan_amount;


-- 9. Active Loans
CREATE VIEW active_loans AS
SELECT
    loan_id,
    customer_id,
    loan_type_id,
    loan_amount,
    loan_date
FROM loans
WHERE loan_status = 'Active';


-- 10. Complete Loan Report
CREATE VIEW complete_loan_report AS
SELECT
    l.loan_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    b.branch_name,
    lt.loan_type_name,
    l.loan_amount,
    l.loan_date,
    l.loan_status
FROM loans l
JOIN customers c
    ON l.customer_id = c.customer_id
JOIN branches b
    ON l.branch_id = b.branch_id
JOIN loan_types lt
    ON l.loan_type_id = lt.loan_type_id;