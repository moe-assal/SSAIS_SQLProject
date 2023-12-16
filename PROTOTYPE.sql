CREATE DATABASE project_db;
USE project_db;

CREATE TABLE address
(
    rue VARCHAR(30),
    building_name VARCHAR(30),
    floor_nb TINYINT,
    city VARCHAR(50),
    country VARCHAR(50),
    PRIMARY KEY (rue, building_name, floor_nb)
);

CREATE TABLE corporation
(
    corporation_id INT UNSIGNED,
    corporation_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (corporation_id) ON DELETE RESTRICT
);

CREATE TABLE corporatefunds
(
    corporate_id INT PRIMARY KEY,
    amount DECIMAL(10, 2) DEFAULT 0.00 CHECK (amount > 0)
);

CREATE TABLE benefits
(
    benefit_id INT UNSIGNED DEFAULT 0,
    PRIMARY KEY (benefit_id)
);

CREATE TABLE survivors
(
    survivor_id INT UNSIGNED,
    specifications VARCHAR(100) NOT NULL,
    PRIMARY KEY (survivor_id),
    FOREIGN KEY (survivor_id) REFERENCES benefits(benefit_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE retirement
(
    retirement_id INT UNSIGNED,
    earning_history INT UNSIGNED,
    expected_year_of_retirement SMALLINT NOT NULL,
    actual_year_of_retirement SMALLINT NOT NULL,
    PRIMARY KEY (retirement_id),
    FOREIGN KEY (retirement_id) REFERENCES benefits(benefit_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE disabled
(
    disabled_id INT UNSIGNED,
    disability_type VARCHAR(100) NOT NULL,
    PRIMARY KEY (disabled_id, disability_type),
    FOREIGN KEY (disabled_id) REFERENCES benefits(benefit_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE law_judge
(
    judge_name VARCHAR(40),
    type_of_court VARCHAR(30) NOT NULL,
    PRIMARY KEY (judge_name)
);

CREATE TABLE medical_operations
(
    operation_name VARCHAR(100),
    operation_description VARCHAR(100) NOT NULL,
    PRIMARY KEY (operation_name)
);

CREATE TABLE medical_program
(
    program_id INT UNSIGNED,
    PRIMARY KEY (program_id)
);

CREATE TABLE insurance
(
    insurance_id INT UNSIGNED,
    insurance_type VARCHAR(30) NOT NULL,
    PRIMARY KEY (insurance_id),
    FOREIGN KEY (insurance_id) REFERENCES medical_program(program_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE health
(
    health_id INT UNSIGNED,
    PRIMARY KEY (health_id),
    FOREIGN KEY (health_id) REFERENCES medical_program(program_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE online_account
(
    account_id INT UNSIGNED,
    creation_date DATE NOT NULL,
    PRIMARY KEY (account_id)
);

CREATE TABLE person
(
    person_id INT UNSIGNED,
    first_name VARCHAR(20) NOT NULL,
    middle_name VARCHAR(20),
    last_name VARCHAR(20) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    marital_status VARCHAR(20) DEFAULT 'single',
    date_of_birth DATE,
    rue VARCHAR(30) NOT NULL,
    building_name VARCHAR(30) NOT NULL,
    floor_nb TINYINT NOT NULL,
    account_id INT UNSIGNED,
    PRIMARY KEY (person_id),
    FOREIGN KEY (rue, building_name, floor_nb) REFERENCES address(rue, building_name, floor_nb) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (account_id) REFERENCES online_account(account_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE worker
(
    worker_id INT UNSIGNED,
    corporation_id INT UNSIGNED NOT NULL,
    worker_role VARCHAR(20),
    starting_year SMALLINT,
    benefit_id INT UNSIGNED NOT NULL,
    rue VARCHAR(30) NOT NULL,
    building_name VARCHAR(30) NOT NULL,
    floor_nb TINYINT NOT NULL,
    PRIMARY KEY (worker_id),
    FOREIGN KEY (corporation_id) REFERENCES corporation(corporation_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (benefit_id) REFERENCES benefits(benefit_id) ON UPDATE CASCADE ON DELETE SET DEFAULT,
    FOREIGN KEY (rue, building_name, floor_nb) REFERENCES address(rue, building_name, floor_nb) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (worker_id) REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE employee
(
    employee_id INT UNSIGNED,
    salary INT UNSIGNED,
    retirement_id INT UNSIGNED NOT NULL,
    rue VARCHAR(30) NOT NULL,
    building_name VARCHAR(30) NOT NULL,
    floor_nb TINYINT NOT NULL,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (employee_id) REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (rue, building_name, floor_nb) REFERENCES address(rue, building_name, floor_nb) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (retirement_id) REFERENCES retirement(retirement_id) ON UPDATE CASCADE ON DELETE SET DEFAULT
);

CREATE TABLE has_address
(
    rue VARCHAR(30),
    building_name VARCHAR(30),
    floor_nb TINYINT,
    corporation_id INT UNSIGNED,
    PRIMARY KEY (rue, building_name, floor_nb, corporation_id),
    FOREIGN KEY (rue, building_name, floor_nb) REFERENCES address(rue, building_name, floor_nb) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (corporation_id) REFERENCES corporation(corporation_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE drugs
(
    drug_id INT UNSIGNED,
    emonth SMALLINT,
    eyear SMALLINT,
    type_of_drug VARCHAR(100),
    pmonth SMALLINT,
    pyear SMALLINT,
    manufacturer VARCHAR(50),
    PRIMARY KEY (drug_id)
);

CREATE TABLE consumes
(
    worker_id INT UNSIGNED,
    health_id INT UNSIGNED,
    drug_id INT UNSIGNED,
    percentage_of_coverage SMALLINT,
    PRIMARY KEY (drug_id, worker_id, health_id),
    FOREIGN KEY (health_id) REFERENCES health(health_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (worker_id) REFERENCES worker(worker_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (drug_id) REFERENCES drugs(drug_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE enrolls_in
(
    person_id INT UNSIGNED,
    program_id INT UNSIGNED,
    date_of_enrollment DATE,
    PRIMARY KEY (person_id, program_id),
    FOREIGN KEY (program_id) REFERENCES medical_program(program_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE appeal_process
(
    process_id INT UNSIGNED,
    process_type VARCHAR(100),
    date_of_application DATE,
    worker_id INT UNSIGNED NOT NULL,
    judge_name VARCHAR(40) NOT NULL,
    place VARCHAR(20),
    PRIMARY KEY (process_id),
    FOREIGN KEY (worker_id) REFERENCES worker(worker_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (judge_name) REFERENCES law_judge(judge_name) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE dependants
(
    dependants_name VARCHAR(30),
    worker_id INT UNSIGNED,
    gender VARCHAR(10),
    date_of_birth DATE,
    PRIMARY KEY (dependants_name, worker_id),
    FOREIGN KEY (worker_id) REFERENCES worker(worker_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE statement
(
    statement_id INT,
    statement_name VARCHAR(20),
    statement_description VARCHAR(100

