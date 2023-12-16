USE project_db;

/* Create a view that combines information from the worker tables along with their corporation details. */
CREATE VIEW employees_combine_corporation (
    first_name,
    last_name,
    worker_id,
    worker_role,
    corporation_name
) AS
SELECT
    first_name,
    last_name,
    worker_id,
    worker_role,
    corporation_name
FROM
    person P
    JOIN worker W ON P.person_id = W.worker_id
    JOIN corporation C ON W.corporation_id = C.corporation_id;

DELIMITER //

CREATE FUNCTION nb_of_employees_per_company(C_id INTEGER)
RETURNS INTEGER
BEGIN
    DECLARE c_count INTEGER;

    SELECT COUNT(*) INTO c_count
    FROM worker w
    WHERE w.corporation_id = C_id;

    RETURN c_count;
END //

CREATE FUNCTION percentage_of_coverage_of_insurance(insurance_type VARCHAR(30))
RETURNS INTEGER
DETERMINISTIC
BEGIN
    DECLARE coverage_percentage INTEGER;

    CASE insurance_type
        WHEN 'Platinum' THEN SET coverage_percentage = 90;
        WHEN 'Gold' THEN SET coverage_percentage = 70;
        WHEN 'Silver' THEN SET coverage_percentage = 60;
        ELSE SET coverage_percentage = 50;
    END CASE;

    RETURN coverage_percentage;
END //

/* To automatically add the new corporations later */
CREATE TRIGGER AfterInsertCorporation
AFTER INSERT
ON corporation FOR EACH ROW
BEGIN
    -- Insert the new corporate ID with an initial amount of funds into CorporateFunds
    INSERT INTO CorporateFunds (corporate_id) VALUES (NEW.corporation_id);
END //

CREATE TRIGGER AfterDeleteDoes
AFTER DELETE
ON does FOR EACH ROW
BEGIN
    DECLARE cost_coverage FLOAT;
    DECLARE perc_coverage FLOAT;
    DECLARE funds FLOAT;
    DECLARE corp INT UNSIGNED;

    -- Get perc_coverage
    SET perc_coverage = percentage_of_coverage_of_insurance((SELECT i.insurance_type FROM insurance i WHERE i.insurance_id = OLD.insurance_id));

    -- Calculate true cost
    SET cost_coverage = OLD.cost * perc_coverage;

    -- Get corp
    SELECT w.corporation_id INTO corp FROM worker w WHERE w.worker_id = OLD.worker_id;

    -- Get old fund amount
    SELECT amount INTO funds
    FROM CorporateFunds cf
    WHERE cf.corporate_id = corp;

    -- Update table using stored procedure
    CALL UPDATE_FUNDS(corp, -cost_coverage);
END //

CREATE TABLE CorporateFunds (
    corporate_id INT PRIMARY KEY,
    amount DECIMAL(10, 2) DEFAULT 0.00 CHECK (amount > 0)
) //

CREATE TRIGGER InsteadOfInsertDoes
BEFORE INSERT
ON does FOR EACH ROW
BEGIN
    DECLARE cost_coverage INT;
    DECLARE perc_coverage FLOAT;
    DECLARE funds FLOAT;
    DECLARE corp INT UNSIGNED;
    
    -- Get perc_coverage
    SET perc_coverage = percentage_of_coverage_of_insurance((SELECT i.insurance_type FROM insurance i WHERE i.insurance_id = NEW.insurance_id));
    -- Calculate true cost
    SET cost_coverage = NEW.cost * perc_coverage;
    
    -- Get corp
    SELECT w.corporation_id INTO corp FROM worker w WHERE w.worker_id = NEW.worker_id;
    
    -- Get old fund amount
    SELECT amount INTO funds
    FROM CorporateFunds cf
    WHERE cf.corporate_id = corp;

    -- Stop insertion if limit exceeded
    IF cost_coverage + funds > @fund_limit THEN
        SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Integrity constraint violation: fund limit exceeded.';
    END IF;
    
    -- Update table using stored procedure
    CALL UPDATE_FUNDS(corp, cost_coverage);
END //

-- UPDATE_FUNDS stored procedure
CREATE PROCEDURE UPDATE_FUNDS(IN corp_id INT UNSIGNED, IN fund_change FLOAT)
BEGIN
    -- Update the funds for the specified corporation
    UPDATE CorporateFunds
    SET amount = amount + fund_change
    WHERE corporate_id = corp_id;
END //

DELIMITER ;

/* Covering and Overlapping Constraints Checks for all ISA hierarchies */

CREATE ASSERTION ISA_Benefits
CHECK (
    (
        SELECT COUNT(survivor_id)
        FROM survivor
        WHERE survivor_id NOT IN (SELECT retirement_id FROM retirement) AND survivor_id NOT IN (SELECT disabled_id FROM disabled)
    ) + (
        SELECT COUNT(retirement_id)
        FROM retirement
        WHERE retirement_id NOT IN (SELECT survivor_id FROM survivor) AND retirement_id NOT IN (SELECT disabled_id FROM disabled)
    ) + (
        SELECT COUNT(disabled_id)
        FROM disabled
        WHERE disabled_id NOT IN (SELECT survivor_id FROM survivor) AND disabled_id NOT IN (SELECT retirement_id FROM retirement)
    ) = (SELECT COUNT(benefit_id) FROM benefits)
);

CREATE ASSERTION ISA_medical_program
CHECK (
    (
        SELECT COUNT(insurance_id)
        FROM insurance
        WHERE insurance_id NOT IN (SELECT health_id FROM health)
    ) + (
        SELECT COUNT(health_id)
        FROM health
        WHERE health_id NOT IN (SELECT insurance_id FROM insurance)
    ) = (SELECT COUNT(program_id) FROM medical_program)
);

CREATE ASSERTION ISA_Person
CHECK (
    (
        SELECT COUNT(worker_id)
        FROM worker
        WHERE worker_id NOT IN (SELECT employee_id FROM employee)
    ) + (
        SELECT COUNT(employee_id)
        FROM employee
        WHERE employee_id NOT IN (SELECT worker_id FROM worker)
    ) = (SELECT COUNT(person_id) FROM person)
);

