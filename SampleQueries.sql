USE project_db;

/*for every process type, get the number of workers that requested it */SELECT   process_type,
         Count(*)
FROM     worker
JOIN     appeal_process
using    (worker_id)
GROUP BY process_type;

/*Retrieve the statements for a specific account within a given date range */SELECT statement_name
FROM   statement
WHERE  statement_date BETWEEN 2023 - 01 - 31 AND    2023 - 04 - 15
AND    account_id =               **input**;

/*Find the number of appeals processed by each law judge */SELECT   judge_name,
         Count(*)
FROM     appeal_process
GROUP BY judge_name;

/*Find the average salary of employees who have a retirement plan */SELECT Avg(salary)
FROM   employee e,
       retirement r
WHERE  e.retirement_id = r.retirement_id;

/*Retrieve the  names of  employees who underwent a  medical operation of cost >5000*/SELECT Concat(first_name, middle_name, last_name)
FROM   person
WHERE  person_id IN
       (
              SELECT person_id
              FROM   does
              WHERE  cost > 5000);

/*List the corporations that have number of employees greater than 1*/SELECT C.corporation_name
FROM   corporation C
WHERE  EXISTS
       (
              SELECT corporation_id
              FROM   corporation
              JOIN   worker
              using (corporation_id)
              WHERE  C.corporation_id = corporation_id);

/*Find the average percentage of drug coverage for employees in each corporation*/SELECT   corporation_id,
         Avg(percentage_of_coverage)
FROM     worker
JOIN     consumes
using   (worker_id)
GROUP BY corporation_id;

/*-Find the total cost of medical operations for each corporation, considering all  workers*/SELECT   corporation_id,
         Sum(cost)
FROM     worker
JOIN     does
using   (worker_id)
GROUP BY corporation_id;

/*List all persons who have enrolled in insurance and the corresponding insurance type*/SELECT Concat(first_name, middle_name, last_name),
       insurance_type
FROM   enrolls_in natural
JOIN   insurance natural
JOIN   person;

/*Retrieve the names of workers who have retirement benefits and are also enrolled in a specific medical program */SELECT p.first_name,
       p.middle_name,
       p.last_name
FROM   person p
WHERE  p.person_id IN
       (
              SELECT person_id
              FROM   worker
              JOIN   retirement
              ON     (
                            benefit_id=retirement_id)
              UNION
              SELECT person_id
              FROM   enrolls_in
              JOIN   medical_program
              using  (program_id));

/* List all comapanies whose workers never consumed a drug */SELECT corporation_id
FROM   corporation
EXCEPT
SELECT w.corporation_id
FROM   worker w
WHERE  w.worker_id IN
       (
              SELECT worker_id
              FROM   consumes);

/* List all workers who share the same address of their coroporation */SELECT *
FROM   worker natural
JOIN   has_address;

/* for each company, list the law judges interacting with it*/SELECT DISTINCT corporation_name,
                judge_name
FROM            worker
JOIN            appeal_process
using           (worker_id)
JOIN            corporation
using           (corporation_id);

/* List the workers of all companies consisting of one worker only */SELECT *
FROM   worker w
JOIN
       (
                SELECT   corporation_id
                FROM     worker
                GROUP BY corporation_id
                HAVING   Count(*) = 1 ) AS T
ON     w.corporation_id = T.corporation_id;

/* for each company, list the law judges interacting with it*/SELECT DISTINCT corporation_name,
                judge_name
FROM            worker
JOIN            appeal_process
using           (worker_id)
JOIN            corporation
using           (corporation_id);

/* Find the number of workers in each corporation who are not enrolled in any medical program */SELECT   w.corporation_id,
         Count(w.worker_id)
FROM     worker w
WHERE    w.worker_id NOT IN
         (
                SELECT worker_id
                FROM   enrolls_in natural
                JOIN   medical_program)
GROUP BY w.corporation_id;

/* Find the average age of dependents for workers in each corporation */SELECT   corporation_id,
         Avg(Timestampdiff(year, date_of_birth, Curdate()))
FROM     worker
JOIN     dependants
using    (worker_id)
GROUP BY corporation_id;

/* Get all the workers who's name starts with an M that do not have dependents */SELECT worker_id
FROM   worker
JOIN   person
ON    (
              worker_id=person_id)
WHERE  first_name LIKE 'C%'
EXCEPT
SELECT worker_id
FROM   dependants;

/* Find the number of processes processed by each law judge in an appellate court*/SELECT   judge_name,
         Count(worker_id)
FROM     appeal_process
JOIN     law_judge
using    (judge_name)
WHERE    type_of_court = "magistrate court"
GROUP BY judge_name;

/*Find the number of persons monitored by each law judge in an Magistrate court*/SELECT   judge_name,
         Count(DISTINCT worker_id)
FROM     appeal_process
JOIN     law_judge
using    (judge_name)
WHERE    type_of_court = "magistrate court"
GROUP BY judge_name;

/*Find the number of workers in each corporation who are enrolled in an insurance program*/SELECT   W.corporation_id,
         Count(DISTINCT W.worker_id)
FROM     worker AS W
JOIN     corporation C
ON       (
                  W.corporation_id = C.corporation_id )
JOIN     enrolls_in E
ON       (
                  W.worker_id = E.person_id )
JOIN     insurance I
ON       (
                  E.program_id = I.insurance_id )
GROUP BY W.corporation_id;

/*List all employees who have an online account and the total number of statements they have */SELECT *
FROM   person natural
JOIN   employee natural
JOIN
       (
                SELECT   account_id,
                         Count(statement_id) AS nb_of_statements
                FROM     online_account
                JOIN     statement
                using   (account_id)
                GROUP BY account_id) AS T;

/*list all workers who have at least oneĀ coworker*/SELECT DISTINCT w.worker_id
FROM            worker w
JOIN            worker co
ON              (
                                co.worker_id <> w.worker_id
                AND             co.corporation_id = w.corporation_id);

/*Find workers who have not applied for any medical programs.*/SELECT *
FROM   worker W
WHERE  NOT EXISTS
       (
              SELECT *
              FROM   enrolls_in E
              WHERE  W.worker_id = E.person_id);

/*Retrieve the average earning history of employees enrolled in retirement for each corporation, along with the total number of workers in each corporation*/SELECT   corporation_id,
         Count(*) AS COUNT,
         (
                SELECT Avg(earning_history)
                FROM   worker W2
                JOIN   retirement R
                ON     (
                              W2.benefit_id=R.retirement_id)
                WHERE  W2.corporation_id =C.corporation_id) AS average_earning_history
FROM     worker W
JOIN     corporation C
using    (corporation_id)
GROUP BY corporation_id;

/*Retrieve a list of workers with title "Regular" along with the number of dependents each has.*/SELECT * ,
       (
              SELECT Count(*)
              FROM   dependants D1
              WHERE  W.worker_id =D1.worker_id) AS dependants_count
FROM   worker W
WHERE  W.worker_id IN
       (
              SELECT worker_id
              FROM   worker
              WHERE  worker_role LIKE "regular");

/*Retrieve all  Single workers and their corresponding medical  "Completed " operations descriptions  (if any) */SELECT *
FROM   person P1
WHERE  P1.marital_status LIKE "single"
AND    EXISTS
       (
              SELECT worker_id,
                     (
                            SELECT operation_description
                            FROM   medical_operations
                            WHERE  operation_name=D.operation_name)
              FROM   does D
              WHERE  status LIKE "completed"
              AND    P1.person_id=D.worker_id);

/*  Retrieve the corporation with nb of employees >=1 ordered by average starting year of its employees*/SELECT   *
FROM     corporation C2
JOIN     worker
using    (corporation_id)
WHERE    Nb_of_employees_per_company(C2.corporation_id) >=1
ORDER BY (
                SELECT Avg(starting_year)
                FROM   worker w2
                WHERE  w2.corporation_id = C2.corporation_id);

/*Retrieve the worker with the highest number of dependents*/SELECT   Count(*) AS nb_of_dependants,
         worker_id
FROM     worker natural
JOIN     dependants
GROUP BY worker_id
ORDER BY nb_of_dependants DESC limit 1;

/*Update the roles of workers based on their starting year in a specific company with id = 3*/UPDATE worker W
SET    worker_role =
       CASE
              WHEN Year(CURRENT_DATE)     - starting_year >= 0
              AND    Year(CURRENT_DATE()) - starting_year <= 2 THEN 'Entry Level'
              WHEN Year(CURRENT_DATE)     - starting_year >= 3
              AND    Year(CURRENT_DATE()) - starting_year <= 5 THEN 'Mid Level'
              WHEN Year(CURRENT_DATE)     - starting_year >= 6
              AND    Year(CURRENT_DATE()) - starting_year <= 8 THEN 'Senior Level'
              WHEN Year(CURRENT_DATE)     - starting_year >= 9 THEN 'Executive Level'
              ELSE 'Not Applicable'
       END
WHERE  W.corporation_id = 3;

/* Retrieve the person with the highest total drug coverage percentage */SELECT   C.worker_id
FROM     consumes AS C
GROUP BY C.worker_id
HAVING   Sum(C.percentage_of_coverage) >= ALL
         (
                  SELECT   Sum(C2.percentage_of_coverage)
                  FROM     consumes AS C2
                  GROUP BY C2.worker_id );

/*Retrieve the number of dependent each worker has*/SELECT     Count(dependants_name) AS nb_of_dependants,
           worker_id
FROM       worker W
RIGHT JOIN dependants D
using      (worker_id)
GROUP BY   worker_id;
