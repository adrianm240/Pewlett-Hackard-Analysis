-- Create Retirement with Titles table
SELECT emp.emp_no, 
    emp.first_name, 
    emp.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
INTO retirement_titles
FROM employees AS emp
LEFT JOIN titles AS ti
ON emp.emp_no = ti.emp_no
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles AS rt
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Create Table with Count of Eligible Retirees by Title
SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT (title) DESC;

-- Create Mentorship Eligibility Table
SELECT DISTINCT ON (emp.emp_no) emp.emp_no,
	emp.first_name, 
	emp.last_name, 
	emp.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees AS emp
LEFT JOIN titles AS ti
ON emp.emp_no = ti.emp_no
LEFT JOIN dept_emp AS de
ON emp.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01') 
	AND (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;