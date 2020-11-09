-- Creating the title table
CREATE TABLE title(
  title_id VARCHAR(5) NOT NULL PRIMARY KEY,
  title VARCHAR(20) NOT NULL
);

SELECT * FROM title;
	
-- Creating the employees table

CREATE TABLE employees(
  emp_no INTEGER PRIMARY KEY,
  emp_title_id VARCHAR(5) REFERENCES title (title_id),
  birth_date DATE,
  first_name VARCHAR,
  last_name VARCHAR,
  sex CHAR(1),
  hire_date DATE
);
SELECT COUNT(DISTINCT(emp_title_id)) FROM employees;

SELECT * FROM employees;

-- Creating the salary Table

CREATE TABLE salary(
  emp_no INTEGER PRIMARY KEY REFERENCES employees (emp_no),
  salary INTEGER NOT NULL
);

SELECT * FROM salary;

-- Creating the departments Table

CREATE TABLE departments(
  dept_no VARCHAR(5) PRIMARY KEY,
  dept_name VARCHAR(20) NOT NULL
);

SELECT * FROM departments;

-- Creating the dept_managers table

CREATE TABLE dept_managers(
  dept_no VARCHAR(5) REFERENCES departments (dept_no),
  emp_no INTEGER REFERENCES employees (emp_no)
);

SELECT * FROM dept_managers;

-- Creating the dept_employees table

CREATE TABLE dept_employees(
  emp_no INTEGER REFERENCES employees (emp_no),
  dept_no VARCHAR(5) REFERENCES departments (dept_no)
);

SELECT * FROM dept_employees;

-- List the following details of each employee: employee number, last name, first name, sex, and salary.
Select 
employees.emp_no,
employees.last_name,
employees.first_name,
employees.sex,
s.salary
From salary as s
Inner Join employees on
employees.emp_no = s.emp_no ;

-- List first name, last name, and hire date for employees who were hired in 1986.
Select first_name, last_name, hire_date 
From employees 
Where hire_date >= '1985-12-31' 
AND hire_date < '1987-01-01';

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
Select
dept_managers.dept_no, 
departments.dept_name, 
dept_managers.emp_no,
employees.last_name,
employees.first_name
From dept_managers 
Inner Join departments ON dept_managers.dept_no=departments.dept_no
Inner Join employees On (employees.emp_no=dept_managers.emp_no) ;

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
Select
dept_employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
From dept_employees 
Inner Join departments ON dept_employees.dept_no=departments.dept_no
Inner Join employees On (employees.emp_no=dept_employees.emp_no) ;

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
Select first_name, last_name, sex 
From employees 
Where first_name= 'Hercules' 
AND last_name like 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
Select
dept_employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
From employees
Join dept_employees On dept_employees.emp_no=employees.emp_no
Join departments On (dept_employees.dept_no=departments.dept_no)
Where dept_name='Sales' ;

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
Select
dept_employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
From employees
Join dept_employees On dept_employees.emp_no=employees.emp_no
Join departments On (dept_employees.dept_no=departments.dept_no)
Where dept_name='Sales' OR dept_name='Development' ;

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
Select last_name, 
Count(Last_Name) 
From employees 
Group By last_name 
Order By Count Desc ;