CREATE DATABASE company_training;
USE company_training;

CREATE TABLE departments (
    department_id INT NOT NULL,
    dept_name VARCHAR(80) NOT NULL,
	city VARCHAR(60)
);

 CREATE TABLE employees (
	 employee_id INT NOT NULL,
	 employee_name VARCHAR(100) NOT NULL,
	 email VARCHAR(120),
     department_id INT NOT NULL,
     salary DECIMAL(10,2),
	 status VARCHAR(20)
);

-- 01.  Add a PRIMARY KEY constraint on departments.department_id.
		Alter Table departments Add Primary Key(department_id);
      
-- 02.  Add a PRIMARY KEY constraint on employees.employee_id.
        Alter Table employees Add Primary Key(employee_id);

-- 03.  Add a new column named location of type VARCHAR(100) to the departments table.
        Alter Table departments Add Column Location varchar(100);

-- 04.  Rename the column dept_name to department_name in the departments table, keeping its existing data type and NOT NULL requirement.
		Alter Table departments Change Column dept_name department_name varchar(80) not null; 
         
         
-- 05.  Modify employees.salary to DECIMAL(12,2) and ensure that it does not allow NULL values.
        Alter Table employees  Modify Column salary DECIMAL(12,2);
        
-- 06.  Set the default value of employees.status to Active.
        ALTER TABLE employees ALTER COLUMN status SET DEFAULT 'Active';

-- 07.  Add a UNIQUE constraint on employees.email.
		ALTER TABLE employees ADD CONSTRAINT uq_employees_email UNIQUE (email);

-- 08.  Rename the employees table to staff.
	    RENAME TABLE employees TO staff;

-- 09.  Add a FOREIGN KEY constraint on staff.department_id referencing departments.department_id.
        ALTER TABLE staff ADD CONSTRAINT fk_staff_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id);

-- 10.  Drop the UNIQUE constraint added to staff.email in Question 7.
        ALTER TABLE staff DROP INDEX uq_employees_email;

-- 11.  Drop the FOREIGN KEY constraint created in Question 9 without dropping the department_id column.
        ALTER TABLE staff DROP FOREIGN KEY fk_staff_department;

-- 12.  Drop the PRIMARY KEY constraint from the staff table, retaining its employee_id column.
        ALTER TABLE staff  DROP PRIMARY KEY;

-- 13.  Add the PRIMARY KEY constraint back on staff.employee_id.
		ALTER TABLE staff ADD PRIMARY KEY (employee_id);

-- 14.  Drop the location column from the departments table.
        ALTER TABLE departments  DROP COLUMN location;

-- 15.  Rename the database from company_training to company_management using MySQL-supported DDL operations.
--      Create the new database, move both tables to it,and remove the old empty database,
--      (MySQL does not support a direct RENAME DATABASE command).
        -- 1. frist create new database.
			  CREATE DATABASE company_management;
              
		-- 2. Move table across Database.
              RENAME TABLE 
                  company_training.departments TO company_management.departments,
                  company_training.staff TO company_management.staff;
                  
		-- 3. Remove the old empty database,
		--    Once both tables and all their data are safely inside company_management,
		--    delete the empty company_training database.
			  DROP DATABASE company_training;