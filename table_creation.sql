USE bank_loan_project;

CREATE TABLE branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    city VARCHAR(50),
    state VARCHAR(50),
    join_date DATE
);

CREATE TABLE loan_types (
    loan_type_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_type_name VARCHAR(100) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    loan_type_id INT NOT NULL,
    loan_amount DECIMAL(12,2) NOT NULL,
    loan_date DATE NOT NULL,
    loan_status VARCHAR(30) NOT NULL,
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (loan_type_id) REFERENCES loan_types(loan_type_id)
);

CREATE TABLE loan_payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(12,2) NOT NULL,
    payment_status VARCHAR(30) NOT NULL,

    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);