USE project_db;
-- Inserting data into the 'address' table
INSERT INTO address (rue, building_name, floor_nb, city, country)
VALUES
  ('123 Main St', 'Building A', 1, 'New York', 'United States'),
  ('456 Oak St', 'Building B', 2, 'London', 'United Kingdom'),
  ('789 Maple St', 'Building C', 3, 'Paris', 'France'),
  ('101 Pine St', 'Building D', 4, 'Tokyo', 'Japan'),
  ('202 Cedar St', 'Building E', 5, 'Sydney', 'Australia'),
  ('303 Elm St', 'Building F', 6, 'Berlin', 'Germany'),
  ('404 Birch St', 'Building G', 7, 'Toronto', 'Canada'),
  ('505 Oak St', 'Building H', 8, 'Mumbai', 'India'),
  ('606 Pine St', 'Building I', 9, 'Rio de Janeiro', 'Brazil'),
  ('707 Maple St', 'Building J', 10, 'Cape Town', 'South Africa'),
  ('808 Cedar St', 'Building K', 11, 'Seoul', 'South Korea'),
  ('909 Elm St', 'Building L', 12, 'Moscow', 'Russia'),
  ('1010 Birch St', 'Building M', 13, 'Dubai', 'United Arab Emirates'),
  ('1111 Oak St', 'Building N', 14, 'Mexico City', 'Mexico'),
  ('1212 Pine St', 'Building O', 15, 'Beijing', 'China');

-- Inserting data into the 'online_account' table
INSERT INTO online_account (account_id, creation_date)
VALUES
  (1001, '2022-01-01'),
  (2056, '2022-02-15'),
  (3098, '2022-03-20'),
  (4123, '2022-04-05'),
  (5176, '2022-05-10'),
  (6210, '2022-06-25'),
  (7325, '2022-07-30'),
  (8462, '2022-08-15'),
  (9518, '2022-09-20'),
  (10504, '2022-10-05'),
  (11632, '2022-11-10'),
  (12789, '2022-12-25'),
  (13125, '2023-01-01'),
  (14207, '2023-02-15'),
  (15364, '2023-03-20'),
  (16675, '2023-04-05'),
  (17893, '2023-05-10'),
  (18245, '2023-06-25'),
  (19458, '2023-07-30'),
  (20502, '2023-08-15');

-- Inserting data into the 'corporation' table
INSERT INTO corporation (corporation_id, corporation_name)
VALUES
  (1, 'Google'),
  (2, 'Microsoft'),
  (3, 'Apple'),
  (4, 'Amazon'),
  (5, 'Facebook'),
  (11, 'Global Innovations'),
  (12, 'Tech Solutions Ltd'),
  (6, 'Acme Industries'),
  (7, 'Innovate Co.'),
  (8, 'Dynamic Ventures'),
  (9, 'Swift Enterprises'),
  (10, 'Future Systems');

-- Inserting data into the 'benefits' table
INSERT INTO benefits (benefit_id)
VALUES
  (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
  (11), (12), (13), (14), (15), (16), (17), (18);

-- Inserting data into the 'retirement' table
INSERT INTO retirement (benefit_id, earning_history, expected_year_of_retirement, actual_year_of_retirement)
VALUES
  (1, 50000, 2050, 2055),
  (2, 60000, 2045, 2052),
  (3, 70000, 2040, 2048),
  (4, 80000, 2035, 2043),
  (5, 90000, 2030, 2038),
  (6, 100000, 2025, 2035);

-- Inserting data into the 'disabled' table
INSERT INTO disabled (benefit_id, disability_type)
VALUES
  (7, 'Speech'),
  (8, 'Mobility'),
  (9, 'Chronic Illness'),
  (10, 'Other'),
  (11, 'Physical'),
  (12, 'Mental'),
  (13, 'Visual Impairment'),
  (14, 'Hearing Loss'),
  (15, 'Neurological Disorder'),
  (16, 'Developmental Disability'),
  (17, 'Autoimmune Disease'),
  (18, 'Cognitive Impairment');

-- Inserting data into the 'benefits' table again
INSERT INTO benefits (benefit_id)
VALUES
  (19), (20), (21), (22), (23), (24), (25), (26), (27), (28), (29), (30);

-- Inserting data into the 'survivors' table
INSERT INTO survivors (benefit_id, specifications)
VALUES
  (19, 'Surviving Spouse'),
  (20, 'Dependent Child'),
  (21, 'Surviving Parent'),
  (22, 'Surviving Sibling'),
  (23, 'Other Surviving Relative'),
  (24, 'Dependent Family Member'),
  (25, 'Designated Survivor'),
  (26, 'Surviving Spouse'),
  (27, 'Dependent Child'),
  (28, 'Surviving Parent'),
  (29, 'Surviving Sibling'),
  (30, 'Other Surviving Relative');

-- Inserting data into the 'law_judge' table
INSERT INTO law_judge (judge_name, type_of_court)
VALUES
  ('Judge Smith', 'District Court'),
  ('Judge Johnson', 'Family Court'),
  ('Judge Williams', 'Supreme Court'),
  ('Judge Brown', 'Appellate Court'),
  ('Judge Davis', 'Magistrate Court'),
  ('Judge Wilson', 'Probate Court'),
  ('Judge Taylor', 'Circuit Court'),
  ('Judge Anderson', 'Municipal Court'),
  ('Judge Garcia', 'Juvenile Court'),
  ('Judge Martinez', 'Traffic Court');

-- Inserting data into the 'medical_operations' table
INSERT INTO medical_operations (operation_name, operation_description)
VALUES
  ('Appendectomy', 'Removal of the appendix'),
  ('Cataract Surgery', 'Removal of a cloudy lens in the eye'),
  ('Knee Replacement', 'Replacement of a damaged knee joint'),
  ('Hernia Repair', 'Correction of a hernia through surgery'),
  ('Gallbladder Removal', 'Removal of the gallbladder'),
  ('Angioplasty', 'Opening blocked or narrowed blood vessels'),
  ('Hip Replacement', 'Replacement of a damaged hip joint'),
  ('Tonsillectomy', 'Removal of the tonsils'),
  ('Laparoscopic Cholecystectomy', 'Removal of the gallbladder using minimally invasive techniques'),
  ('Coronary Bypass Surgery', 'Redirecting blood flow around a blocked artery in the heart');

-- Inserting data into the 'medical_program' table
INSERT INTO medical_program (program_id)
VALUES
  (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Inserting data into the 'insurance' table
INSERT INTO insurance (program_id, insurance_type)
VALUES
  (1, 'Health Insurance'),
  (2, 'Dental Insurance'),
  (3, 'Vision Insurance'),
  (4, 'Life Insurance'),
  (5, 'Disability Insurance'),
  (6, 'Accidental Death'),
  (7, 'Critical Illness Insurance'),
  (8, 'Long-Term Care Insurance'),
  (9, 'Travel Insurance');

-- Inserting data into the 'does' table
INSERT INTO does (person_id, operation_name, program_id, cost, status, date_of_operation)
VALUES
  (13, 'Appendectomy', 1, 5000.00, 'Completed', '2023-01-15'),
  (12, 'Cataract Surgery', 2, 7000.00, 'In Progress', '2023-02-20'),
  (9, 'Knee Replacement', 3, 12000.00, 'Scheduled', '2023-03-10'),
  (14, 'Hernia Repair', 4, 4000.00, 'Completed', '2023-04-25'),
  (15, 'Gallbladder Removal', 5, 8000.00, 'Scheduled', '2023-05-18');

-- Inserting data into the 'person' table
INSERT INTO person (person_id, first_name, middle_name, last_name, gender, marital_status, date_of_birth, rue, building_name, floor_nb, account_id)
VALUES
  (1, 'John', 'A', 'Doe', 'Male', 'Single', '1990-01-15', '123 Main St', 'Building A', 1, 1001),
  (2, 'Jane', 'B', 'Smith', 'Female', 'Married', '1985-05-20', '456 Oak St', 'Building B', 2, 2056),
  (3, 'Michael', 'C', 'Johnson', 'Male', 'Divorced', '1982-09-10', '789 Maple St', 'Building C', 3, 3098),
  (4, 'Emily', 'D', 'Williams', 'Female', 'Single', '1995-03-25', '101 Pine St', 'Building D', 4, 4123),
  (5, 'Christopher', 'E', 'Miller', 'Male', 'Married', '1988-11-18', '202 Cedar St', 'Building E', 5, 5176),
  (6, 'Amanda', 'F', 'Jones', 'Female', 'Single', '1991-06-12', '303 Elm St', 'Building F', 6, 6210),
  (7, 'Daniel', 'G', 'Davis', 'Male', 'Married', '1984-02-28', '404 Birch St', 'Building G', 7, 7325),
  (8, 'Olivia', 'H', 'Anderson', 'Female', 'Divorced', '1996-08-15', '505 Oak St', 'Building H', 8, 8462),
  (9, 'Ethan', 'I', 'White', 'Male', 'Single', '1989-04-05', '606 Pine St', 'Building I', 9, 9518),
  (10, 'Sophia', 'J', 'Brown', 'Female', 'Married', '1992-11-28', '707 Maple St', 'Building J', 10, 10504),
  (11, 'Matthew', 'K', 'Smith', 'Male', 'Single', '1983-07-20', '808 Cedar St', 'Building K', 11, 11632),
  (12, 'Isabella', 'L', 'Taylor', 'Female', 'Married', '1994-03-12', '909 Elm St', 'Building L', 12, 12789),
  (13, 'Andrew', 'M', 'Clark', 'Male', 'Divorced', '1986-09-05', '1010 Birch St', 'Building M', 13, 13125),
  (14, 'Mia', 'N', 'Anderson', 'Female', 'Single', '1997-04-30', '1111 Oak St', 'Building N', 14, 14207),
  (15, 'Logan', 'O', 'Jones', 'Male', 'Married', '1981-12-22', '1212 Pine St', 'Building O', 15, 15364);

-- Inserting data into the 'employee' table
INSERT INTO employee (person_id, salary, benefit_id, rue, building_name, floor_nb)
VALUES
  (1, 120000, 1, '123 Main St', 'Building A', 1),
  (2, 150000, 2, '456 Oak St', 'Building B', 2),
  (3, 110000, 3, '789 Maple St', 'Building C', 3),
  (4, 90000, 4, '101 Pine St', 'Building D', 4),
  (5, 130000, 5, '202 Cedar St', 'Building E', 5),
  (6, 95000, 6, '303 Elm St', 'Building F', 6),
  (7, 105000, 5, '404 Birch St', 'Building G', 7),
  (8, 120000, 5, '505 Oak St', 'Building H', 8),
  (11, 110000, 1, '1212 Pine St', 'Building O', 15),
  (10, 130000, 2, '1010 Birch St', 'Building M', 13);

-- Inserting data into the 'worker' table
INSERT INTO worker (person_id, corporation_id, worker_role, starting_year, benefit_id, rue, building_name, floor_nb)
VALUES
  (13, 4, 'Software Developer', 2019, 6, '303 Elm St', 'Building F', 6),
  (12, 2, 'Coordinator', 2020, 8, '505 Oak St', 'Building H', 8),
  (9, 1, 'HR Specialist', 2018, 11, '1212 Pine St', 'Building O', 15),
  (14, 3, 'Financial Planner', 2017, 14, '1111 Oak St', 'Building N', 14),
  (15, 2, 'Project Manager', 2016, 17, '707 Maple St', 'Building J', 10);

-- Inserting data into the 'appeal_process' table
INSERT INTO appeal_process (process_id, process_type, date_of_application, person_id, judge_name, place)
VALUES
  (1, 'Appeal for Disability Benefit', '2023-01-15', 3, 'Judge Williams', 'City Court A'),
  (2, 'Appeal for Denied Medical Claim', '2023-02-20', 7, 'Judge Davis', 'City Court B'),
  (3, 'Appeal for Employment Termination', '2023-03-10', 11, 'Judge Smith', 'City Court C'),
  (4, 'Appeal for Denied Insurance Claim', '2023-04-25', 15, 'Judge Johnson', 'City Court D'),
  (5, 'Appeal for Workers Compensation', '2023-05-18', 12, 'Judge Wilson', 'City Court E');

-- Inserting data into the 'has_address' table
INSERT INTO has_address (rue, building_name, floor_nb, corporation_id)
VALUES
  ('123 Main St', 'Building A', 1, 1),
  ('456 Oak St', 'Building B', 2, 2),
  ('789 Maple St', 'Building C', 3, 3),
  ('101 Pine St', 'Building D', 4, 4),
  ('202 Cedar St', 'Building E', 5, 5),
  ('303 Elm St', 'Building F', 6, 6),
  ('404 Birch St', 'Building G', 7, 7),
  ('505 Oak St', 'Building H', 8, 8),
  ('606 Pine St', 'Building I', 9, 9),
  ('707 Maple St', 'Building J', 10, 10);

-- Inserting data into the 'drugs' table
INSERT INTO drugs (drug_id, emonth, eyear, type_of_drug, pmonth, pyear, manufacturer)
VALUES
  (1, 6, 2023, 'Antibiotic', 3, 2023, 'PharmaCorp'),
  (2, 9, 2023, 'Painkiller', 5, 2023, 'MediCare Labs'),
  (3, 12, 2023, 'Antihistamine', 8, 2023, 'GlobalPharma'),
  (4, 2, 2024, 'Antidepressant', 11, 2023, 'LifeWell Pharmaceuticals'),
  (5, 4, 2024, 'Blood Pressure Medication', 1, 2024, 'HealthCare Solutions'),
  (6, 7, 2024, 'Antacid', 4, 2024, 'PharmaCare Inc.'),
  (7, 11, 2023, 'Insulin', 8, 2023, 'Diabetes Pharma'),
  (8, 2, 2025, 'Anti-inflammatory', 1, 2025, 'Relief Pharmaceuticals'),
  (9, 6, 2024, 'Cough Syrup', 3, 2024, 'ColdCare Labs'),
  (10, 10, 2024, 'Antifungal Cream', 7, 2024, 'Dermatology Solutions');

-- Inserting data into the 'consumes' table
INSERT INTO consumes (person_id, program_id, drug_id, percentage_of_coverage)
VALUES
  (1, 1, 1, 80),
  (2, 2, 3, 90),
  (3, 3, 5, 75),
  (4, 4, 2, 85),
  (5, 5, 4, 70),
  (6, 6, 6, 95),
  (7, 7, 8, 60),
  (8, 8, 10, 80),
  (9, 9, 1, 90),
  (10, 10, 3, 75);

-- Inserting data into the 'enrolls_in' table
INSERT INTO enrolls_in (person_id, program_id, date_of_enrollment)
VALUES
  (1, 1, '2022-05-10'),
  (2, 2, '2022-08-15'),
  (3, 3, '2022-11-20'),
  (4, 4, '2023-02-25'),
  (5, 5, '2023-06-01'),
  (6, 6, '2023-09-05'),
  (7, 7, '2023-12-10'),
  (8, 8, '2024-03-15'),
  (9, 9, '2024-06-20'),
  (10, 10, '2024-09-25');

-- Inserting data into the 'statement' table
INSERT INTO statement (statement_id, statement_name, statement_description, account_id, statement_date)
VALUES
  (1, 'Monthly Statement', 'Summary of monthly transactions', 1001, '2023-01-31'),
  (2, 'Year-End Report', 'Annual financial overview', 2056, '2023-12-31'),
  (3, 'Quarterly Update', 'Performance summary for Q1', 3098, '2023-03-31'),
  (4, 'Expense Report', 'Breakdown of monthly expenses', 4123, '2023-02-28'),
  (5, 'Investment Review', 'Analysis of investment holdings', 5176, '2023-04-15'),
  (6, 'Credit Statement', 'Summary of credit card transactions', 6210, '2023-03-15'),
  (7, 'Tax Statement', 'Annual tax document', 7325, '2023-01-15');

-- Inserting data into the 'health' table
INSERT INTO health(program_id)
VALUES
  (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Inserting data into the 'retirement' table
INSERT INTO retirement (benefit_id, earning_history, expected_year_of_retirement, actual_year_of_retirement)
VALUES
  (9, 10000, 2050, 2052),
  (10, 12000, 2052, 2054),
  (11, 15000, 2055, 2057),
  (12, 18000, 2058, 2060);

