--task1.1
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    department,
    salary
FROM employees
ORDER BY salary DESC;

--task1.2
SELECT DISTINCT department
FROM employees
ORDER BY department;

--task1.3
SELECT
    project_name,
    budget,
    CASE
        WHEN budget > 150000 THEN 'Large'
        WHEN budget BETWEEN 100000 AND 150000 THEN 'Medium'
        ELSE 'Small'
    END AS budget_category
FROM projects
ORDER BY budget DESC;

--task1.4
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    COALESCE(email, 'No email provided') AS email
FROM employees
ORDER BY full_name;



--task2.1
SELECT *
FROM employees
WHERE hire_date > '2020-01-01'
ORDER BY hire_date;

--task2.2
SELECT *
FROM employees
WHERE salary between 60000 and 70000
order by salary;

--task2.3
select *
from employees
where last_name like 'S%' OR last_name like 'J%'
order by last_name;

--task2.4
select *
from employees
where manager_id is not null and department = 'IT'
order by manager_id;



--task3.1
select
    first_name,
    upper(first_name) as upper_name,
    length(last_name) as name_len,
    substring(email from 1 for 3)
from employees
order by name_len;

--task3.2
select
    employees.first_name,
    employees.salary as annual_salary,
    round(employees.salary / 12, 2) as month_salary,
    round(employees.salary * 0.10) as raise_amount
from employees
order by annual_salary;

--task3.3
select
    format('Project: %s - Budget: %s - Status: %s',
    project_name,
    budget,
    status) as project_info
from projects;

--task3.4
select extract(YEAR from employees.hire_date) as hire_date,
       age(current_date, employees.hire_date) as years_with_company
from employees;

--task4.1
select employees.department, avg(employees.salary)
from employees
group by department;

--task4.2
select
    p.project_name,
    sum(a.hours_worked)
from projects as p
join assignments as a
    on p.project_id = a.project_id
group by project_name;

--task4.3
select
    employees.department
from employees
group by department
having count(department) > 1;

--task4.4
select
    employees.department,
    max(employees.salary),
    min(employees.salary),
    sum(employees.salary)
from employees
group by department;



--task5.1
select
    employee_id,
    concat(employees.first_name, ' ', last_name) as full_name,
    salary
from employees
where salary > 65000
union
select
    employee_id,
    concat(employees.first_name, ' ', last_name) as full_name,
    salary
from employees
where hire_date > '2020-01-01'
order by employee_id;

--task5.2
select *
from employees
where department = 'IT'
intersect
select *
from employees
where salary > 65000
group by employee_id;

--task5.3
SELECT
  employee_id,
  first_name,
  last_name
FROM employees
EXCEPT
SELECT
  e.employee_id,
  e.first_name,
  e.last_name
FROM employees AS e
JOIN assignments AS a
  ON e.employee_id = a.employee_id;



--task6.1
select employees.employee_id,
       employees.first_name,
       employees.last_name
from employees
where exists(
          select 1 from assignments where assignments.employee_id = employees.employee_id
);

--task6.2
SELECT
  e.employee_id,
  e.first_name,
  e.last_name
FROM employees AS e
WHERE
  e.employee_id IN (
    SELECT DISTINCT
      a.employee_id
    FROM assignments AS a
    JOIN projects AS p
      ON a.project_id = p.project_id
    WHERE
      p.status = 'Active'
  );

--task6.3
select *
from employees
where salary > any (
    select salary
    from employees
    where department = 'Sales'
);



--task7.1
SELECT
  e.employee_id,
  CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
  e.department,
  AVG(a.hours_worked) AS average_hours_worked_per_employee,
  e.salary
FROM employees AS e
JOIN assignments AS a
  ON e.employee_id = a.employee_id
GROUP BY
  e.employee_id,
  e.first_name,
  e.last_name,
  e.department,
  e.salary
ORDER BY
  e.department,
  e.salary ASC; -- Orders by salary descending within each department

--task7.2
select
    p.project_name,
    sum(a.hours_worked) as total_hours,
    count(distinct a.employee_id) as number_of_employees
from projects as p
join assignments as a
    on a.project_id = p.project_id
group by
    project_name
having sum(a.hours_worked) > 150
order by total_hours asc;

--task7.3
WITH DepartmentStats AS (
  SELECT
    department,
    COUNT(employee_id) AS total_employees,
    AVG(salary) AS average_salary
  FROM employees
  GROUP BY
    department
),
RankedEmployees AS (
  SELECT
    employee_id,
    first_name,
    last_name,
    department,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
  FROM employees
)
SELECT
  ds.department,
  ds.total_employees,
  ds.average_salary,
  CONCAT(re.first_name, ' ', re.last_name) AS highest_paid_employee_name,
  GREATEST(ds.average_salary, re.salary) AS greatest_of_avg_and_top_salary -- Example use of GREATEST
  -- LEAST(ds.average_salary, re.salary) AS least_of_avg_and_top_salary -- Example use of LEAST
FROM DepartmentStats AS ds
JOIN RankedEmployees AS re
  ON ds.department = re.department
WHERE
  re.rn = 1 -- Selects only the highest-paid employee for each department
ORDER BY
  ds.department;


