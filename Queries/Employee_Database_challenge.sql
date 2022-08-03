-- Module 7 Challenge: Deliverable 1 - Steps 1-7
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no, t.to_date DESC;
-- Module 7 Challenge: Deliverable 1 - Steps 8-15
SELECT DISTINCT ON (rt.emp_no) 
    rt.emp_no,
	rt.first_name,
	rt.last_name,
	t.title
INTO unique_titles
FROM retirement_titles as rt
LEFT JOIN titles as t
	ON (rt.emp_no = t.emp_no)
WHERE t.to_date = '9999-01-01'
ORDER BY rt.emp_no, t.to_date DESC;
-- Module 7 Challenge: Deliverable 1 - Steps 16-21
SELECT COUNT(title),
    title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;
--
-- Deliverable 2: Mentorship Program
SELECT DISTINCT ON (emp_no)
    e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
    ON (de.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
    AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;
--