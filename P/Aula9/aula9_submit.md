# BD: Guião 9


## ​9.1
 
### *a)*

```
CREATE PROCEDURE remove_employee @emp_ssn CHAR(9)
AS
    DELETE FROM dependent WHERE essn = @emp_ssn;
    DELETE FROM works_on WHERE essn = @emp_ssn;
    UPDATE Mgr_ssn SET Mgr_ssn = NULL WHERE Mgr_ssn = @emp_ssn;
    UPDATE Super_ssn SET Super_ssn = NULL WHERE Super_ssn = @emp_ssn;
    DELETE FROM employee WHERE ssn = @emp_ssn;
```

### *b)* 

```
CREATE PROCEDURE get_managers_and_oldest_manager (@oldest_manager INT OUTPUT)
AS
    SELECT TOP 1 @oldest_manager = Ssn
    FROM department JOIN employee ON Dno = Dnumber
    ORDER BY Mgr_start_date DESC
    SELECT * FROM (department JOIN employee ON Mgr_ssn = Ssn)
go
```

### *c)* 

```
CREATE TRIGGER manager_restriction ON department
INSTEAD OF INSERT, UPDATE
AS
	DECLARE @Mgr_ssn INT;
	SELECT @Mgr_ssn=Mgr_ssn FROM inserted;

	IF @Mgr_ssn IN (SELECT Mgr_ssn FROM department)
		PRINT 'ERROR! Manager already managing one department. It may not manage another';
	ELSE
		BEGIN
		INSERT INTO department SELECT * FROM inserted;
		PRINT 'OK!'
		END
```

### *d)* 

```
CREATE TRIGGER no_raises ON employee AFTER UPDATE, INSERT
AS
	DECLARE @new_emp_salary INT;
	DECLARE @new_emp_ssn CHAR(9);
	DECLARE @dep_no INT;
	DECLARE @dep_mgr_salary INT;
	DECLARE @dep_mgr_ssn CHAR(9);
	SELECT @dep_no = Dno, @new_emp_salary = Salary, @new_emp_ssn = ssn FROM inserted;
	SELECT @dep_mgr_ssn = Mgr_ssn FROM department WHERE Dnumber = @dep_no;
	SELECT @dep_mgr_salary = Salary FROM employee WHERE ssn = @dep_mgr_ssn;

	IF @new_emp_salary > @dep_mgr_salary
	BEGIN
		UPDATE employee SET Salary=@dep_mgr_salary-1 WHERE ssn=@new_emp_ssn;
		PRINT 'Salary readjusted';
	END
	ELSE 
		PRINT 'Salary doesnt need to be readjusted';
```

### *e)* 

```
CREATE FUNCTION get_emp_name_and_proj_locations (@ssn CHAR(9)) RETURNS TABLE
AS
	RETURN (SELECT DISTINCT Pname, Plocation FROM employee JOIN works_on ON Essn=@ssn JOIN project ON Pno=Pnumber);
```

### *f)* 

```
CREATE FUNCTION get_emps_with_higher_avg_salary (@dno INT) RETURNS TABLE
AS
	RETURN (
		SELECT * FROM employee AS E WHERE @dno=Dno AND E.salary > (
			SELECT AVG(Salary) FROM employee WHERE Dno=@dno
		)
	);
```

### *g)* 

```
CREATE FUNCTION employeeDeptHighAverage(@departId  INT)
RETURNS @table TABLE (
	pname  VARCHAR(15), 
	pnumber INT, 
	plocation VARCHAR(15), 
	dnum INT, 
	budget FLOAT, 
	totalbudget FLOAT )
AS

BEGIN
	DECLARE C CURSOR
        FOR
            SELECT Pname, Pnumber, Plocation, Dnum, SUM((Salary/40)*Hours) AS Budget  
			 FROM (project JOIN works_on ON Pnumber=Pno) JOIN employee ON Essn=Ssn WHERE Dnum=@departId
			  GROUP BY Pnumber, Pname, Plocation, Dnum;
 
	DECLARE @pname AS VARCHAR(15), @pnumber AS INT, @plocation as VARCHAR(15), @dnum AS INT, @budget AS FLOAT, @totalbudget AS FLOAT;
	SET @totalbudget = 0;
    OPEN C;
	FETCH C INTO @pname, @pnumber, @plocation, @dnum, @budget;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @totalbudget += @budget;
		INSERT INTO @table VALUES (@pname, @pnumber, @plocation, @dnum, @budget, @totalbudget);
		FETCH C INTO @pname, @pnumber, @plocation, @dnum, @budget;
	END
	CLOSE C;
	DEALLOCATE C;
	RETURN;
END
```

### *h)* 

```
CREATE TRIGGER dep_deletion_instead_of ON department INSTEAD OF DELETE
AS
	IF NOT (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'department_deleted'))
		CREATE TABLE department_deleted (
		Dname VARCHAR(15) NOT NULL,
		Dnumber INT NOT NULL,
		Mgr_ssn CHAR(9),
		Mgr_start_date DATE,
		PRIMARY KEY (Dnumber),
		UNIQUE (Dname),
		FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn) 
	);
	INSERT INTO department_deleted SELECT * FROM deleted;
	DELETE FROM department WHERE Dnumber IN (SELECT A.Dnumber FROM deleted AS A);


CREATE TRIGGER dep_deletion ON department AFTER DELETE
AS
	IF NOT (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'department_deleted'))
		CREATE TABLE department_deleted (
		Dname VARCHAR(15) NOT NULL,
		Dnumber INT NOT NULL,
		Mgr_ssn CHAR(9),
		Mgr_start_date DATE,
		PRIMARY KEY (Dnumber),
		UNIQUE (Dname),
		FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn) 
	);
	INSERT INTO department_deleted SELECT * FROM deleted;
```

### *i)* 

```
Stored Procedures e UDFs têm diferentes vantagens e desvantagens em bancos de dados. Stored Procedures encapsulam lógica complexa, controlam transações e são flexíveis para tarefas administrativas, mas não podem ser usadas em SELECT e são menos modulares. UDFs são modulares, reutilizáveis em SELECT, e boas para cálculos e transformações, mas não gerem transações e são menos eficientes em operações complexas. Stored Procedures são ideais para operações complexas e administrativas, enquanto UDFs são melhores para cálculos simples e transformações dentro de SELECT. A escolha depende das necessidades específicas da aplicação.
```
