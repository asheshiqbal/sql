--1. Display all employees, their current annual salary (not including commission) and what their annual salary would be if they were given a 10% pay rise.
select empname, empmsal*12 as annual_sal, (empmsal+(empmsal*.1))*12 as new_annual from employee;
--2. Display the name of all employees, their birthdate and their age in years.
select empname,empbdate,round((sysdate-empbdate)/365,2) as age from employee;
--3. Display all employees, their job and their current annual salary (including commission).
select empname,empjob,empmsal,(empmsal+nvl(empcomm,0))*12 as annual_sal from employee;
--4. Display all employees’ details in the following format: EMPLOYEE N. Smith IS A Trainer AND WORKS IN THE Training DEPARTMENT.
select 'EMPLOYEE '||empinit ||'.'||empname||' IS A '||empjob||' AND WORKS IN THE '||d.deptname||' DEPARTMENT ' from employee e,department d
where e.deptno=d.deptno;
--5. Display the name of all employees, their birthdate and their age in months.
select empname, empbdate, (sysdate-empbdate)/30 as age from employee; 
--6. Display the employees who were born in February.
select empname, empbdate from employee
where to_char(empbdate,'MON') = 'FEB';
--7. Display the employees (using the GREATEST function) who earn more commission than their monthly salary.
select empname,empcomm,empmsal from employee
where empcomm>empmsal;
--8. Display the name of all employees and their birthdate in the following format: EMPLOYEE N. Smith was born on FRIDAY the 17 of DECEMBER , 1965
select 'EMPLOYEE '||empinit||'. '||empname||' was born on '||to_char(empbdate,'day')||'the '||to_char(empbdate,'dd')||' of '||to_char(empbdate,'month')||', '||to_char(empbdate,'yyyy') from employee;
--9. Display the name of the employees who have registered for a course and the number of times they have registered.
select empname, count(*) from employee em, registration rg
where em.empno=rg.empno group by em.empno, empname;
--10. Who is the oldest employee?
select empname from employee 
where empbdate = (select min(empbdate) from employee);
--11. For each department list the department number and name, the number of employees, the minimum and maximum monthly salary, the total monthly salary and the average salary paid to their employees. Name the columns: NbrOfEmployees, MinSalary, MaxSalary, TotalSalary, AvgSalary
select d.deptno,deptname,count(e.empno),min(empmsal),max(empmsal),count(empmsal),avg(empmsal) from employee e,department d
where e.deptno=d.deptno
group by d.deptno,deptname;
--12. Display the jobs in each department and the total monthly salary paid for each job.
select deptname,empjob,sum(empmsal) from employee e,department d
where e.empno=d.empno
group by deptname,empjob;
--13. Which employee earns more than the average salary?
select empname from employee
where empmsal>(select avg(empmsal) from employee);
--14. Which department has the greatest average monthly salary?
select deptname from department d, employee e
where e.deptno=d.deptno
having avg(empmsal)=(select max(avg(empmsal)) from employee group by deptno)
group by deptname;
--15. Which course has the most offerings?
select crscode from offering
having count(crscode)=(select max(count(crscode)) from offering group by crscode)
group by crscode;
--16. Display the name of employees who perform the same job as SCOTT and were born in the same year. Do not include SCOTT in the output.
select empname from employee
where (empjob,to_char(empbdate,'yyyy'))=(select empjob,to_char(empbdate,'yyyy') from employee where empname='SCOTT') and empname not like 'SCOTT';
--17. Using the MINUS statement, which employees have never registered in a course.
select empno from employee minus select empno from registration;
--18. Using the INTERSECT statement, which employees have both registered for and conducted courses.
select empno from registration intersect select empno from offering;  
--19. Add the following details to the employee table. Employee number: 9999, name: H.B. Bear, birthdate: 21st July 1965, monthly salary: $3500, department same as MILLER
INSERT INTO employee(empno, empname, empinit, empbdate, empmsal, deptno) 
VALUES (9999, 'Bear', 'H.B.', to_date('21-JUL-1965','dd-MON-yyyy'), 3550, (SELECT deptno FROM employee WHERE empname = 'MILLER'));
--20. Update employee H B. Bear's monthly salary to the same amount as KING's, his job to the same as CLARK's and his department to SALES.
UPDATE employee 
SET empmsal = (SELECT empmsal FROM employee WHERE empname = 'KING'), empjob = (SELECT empjob FROM employee WHERE empname = 'CLARK'), deptno = (SELECT deptno FROM department WHERE deptname = 'SALES')
WHERE empno = 9999;
--21. Delete employee HB. Bear.
DELETE FROM employee
WHERE empno = 9999;