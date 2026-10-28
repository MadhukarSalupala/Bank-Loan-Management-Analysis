USE bank_loan_project;


-- 1. Get all loans
DROP PROCEDURE IF EXISTS GetAllLoans;

DELIMITER //

CREATE PROCEDURE GetAllLoans()
BEGIN
    SELECT *
    FROM loans;
END //

DELIMITER ;

CALL GetAllLoans();


-- 2. Get loans of a particular customer
DROP PROCEDURE IF EXISTS GetCustomerLoans;

DELIMITER //

CREATE PROCEDURE GetCustomerLoans(IN p_customer_id INT)
BEGIN
    SELECT *
    FROM loans
    WHERE customer_id = p_customer_id;
END //

DELIMITER ;

CALL GetCustomerLoans(1);


-- 3. Get loans by status
DROP PROCEDURE IF EXISTS GetLoansByStatus;

DELIMITER //

CREATE PROCEDURE GetLoansByStatus(IN p_status VARCHAR(30))
BEGIN
    SELECT *
    FROM loans
    WHERE loan_status = p_status;
END //

DELIMITER ;

CALL GetLoansByStatus('Approved');


-- 4. Get loans by branch
DROP PROCEDURE IF EXISTS GetLoansByBranch;

DELIMITER //

CREATE PROCEDURE GetLoansByBranch(IN p_branch_id INT)
BEGIN
    SELECT *
    FROM loans
    WHERE branch_id = p_branch_id;
END //

DELIMITER ;

CALL GetLoansByBranch(1);


-- 5. Get loans by loan type
DROP PROCEDURE IF EXISTS GetLoansByType;

DELIMITER //

CREATE PROCEDURE GetLoansByType(IN p_loan_type_id INT)
BEGIN
    SELECT *
    FROM loans
    WHERE loan_type_id = p_loan_type_id;
END //

DELIMITER ;

CALL GetLoansByType(1);


-- 6. Get loans above a certain amount
DROP PROCEDURE IF EXISTS GetHighValueLoans;

DELIMITER //

CREATE PROCEDURE GetHighValueLoans(IN p_amount DECIMAL(12,2))
BEGIN
    SELECT *
    FROM loans
    WHERE loan_amount > p_amount;
END //

DELIMITER ;

CALL GetHighValueLoans(500000);


-- 7. Get total loan amount of a customer
DROP PROCEDURE IF EXISTS GetCustomerLoanTotal;

DELIMITER //

CREATE PROCEDURE GetCustomerLoanTotal(IN p_customer_id INT)
BEGIN
    SELECT
        customer_id,
        COUNT(*) AS total_loans,
        SUM(loan_amount) AS total_loan_amount
    FROM loans
    WHERE customer_id = p_customer_id
    GROUP BY customer_id;
END //

DELIMITER ;

CALL GetCustomerLoanTotal(1);


-- 8. Get total loans and amount by branch
DROP PROCEDURE IF EXISTS GetBranchSummary;

DELIMITER //

CREATE PROCEDURE GetBranchSummary(IN p_branch_id INT)
BEGIN
    SELECT
        branch_id,
        COUNT(*) AS total_loans,
        SUM(loan_amount) AS total_loan_amount
    FROM loans
    WHERE branch_id = p_branch_id
    GROUP BY branch_id;
END //

DELIMITER ;

CALL GetBranchSummary(1);


-- 9. Get loans between two dates
DROP PROCEDURE IF EXISTS GetLoansByDate;

DELIMITER //

CREATE PROCEDURE GetLoansByDate(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT *
    FROM loans
    WHERE loan_date BETWEEN p_start_date AND p_end_date;
END //

DELIMITER ;

CALL GetLoansByDate('2025-01-01', '2025-12-31');


-- 10. Get customer loan details
DROP PROCEDURE IF EXISTS GetCustomerLoanDetails;

DELIMITER //

CREATE PROCEDURE GetCustomerLoanDetails(IN p_customer_id INT)
BEGIN
    SELECT
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        l.loan_id,
        l.loan_amount,
        l.loan_date,
        l.loan_status,
        lt.loan_type_name,
        b.branch_name
    FROM customers c
    JOIN loans l
        ON c.customer_id = l.customer_id
    JOIN loan_types lt
        ON l.loan_type_id = lt.loan_type_id
    JOIN branches b
        ON l.branch_id = b.branch_id
    WHERE c.customer_id = p_customer_id;
END //

DELIMITER ;

CALL GetCustomerLoanDetails(1);