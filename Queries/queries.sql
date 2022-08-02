-- Module 7.3.1
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
--
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';
--
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
--
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';
--
-- Retirement eligibility
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Number of employees retiring
--
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT * FROM retirement_info;
--
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;
--
-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;
--
-- Joining retirement_info and dept_emp tables
-- SELECT retirement_info.emp_no,
--     retirement_info.first_name,
-- 	retirement_info.last_name,
--     dept_emp.to_date
-- FROM retirement_info
-- LEFT JOIN dept_emp
-- ON retirement_info.emp_no = dept_emp.emp_no;
-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;
--
-- refactor retirement_info table to include only current employees
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
--
-- Module 7.3.4
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO retire_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
--
-- Module 7.3.5
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.gender, sal.salary, de.to_date
INTO emp_info
FROM employees as emp
INNER JOIN salaries as sal
ON (emp.emp_no = sal.emp_no)
INNER JOIN dept_emp as de
ON (emp.emp_no = de.emp_no)
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (emp.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');
--
-- List of Managers per department
SELECT dmgr.dept_no, dept.dept_name, dmgr.emp_no, emp.last_name, emp.first_name, dmgr.from_date, dmgr.to_date
INTO mgr_info
FROM dept_manager as dmgr
	INNER JOIN departments as dept
		ON (dmgr.dept_no = dept.dept_no)
	INNER JOIN employees as emp
		ON (dmgr.emp_no = emp.emp_no)
-- WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--     AND (emp.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
-- 	AND (dmgr.to_date = '9999-01-01');
WHERE dmgr.to_date = '9999-01-01'
--
-- Projected Retirees by Department
SELECT d.dept_name, de.emp_no, e.last_name, e.first_name
INTO dept_info
FROM dept_emp as de
	LEFT JOIN employees as e
		ON (de.emp_no = e.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--
-- Module 7.3.6 Create a tailored list
-- Sales team list
SELECT emp_no, first_name, last_name, dept_name
FROM dept_info
WHERE dept_name = 'Sales';
--
-- Sales and Development teams list
SELECT emp_no, first_name, last_name, dept_name
FROM dept_info
WHERE (dept_name = 'Sales')
	OR (dept_name = 'Development');
--
SELECT * FROM departments;