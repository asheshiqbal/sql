--1. Display the employees who earn less than $1000.
select empno,empname from employee
where empmsal>1000;
--2. List the department number of departments that have employees.
select deptno from department
where empno is not null;
--3. Display the trainers who earn less than 2500 each month and are working in department 20.
select empno,empname from employee
where empmsal<2500 and deptno=20;
--4. Display the name, job, monthly salary and commission of employees whose monthly salary is higher than their commission. Rename the columns: Name, Job, Monthly Salary and Commission.
select empname as "Name",empjob as "Job",empmsal as "Monthly Salary",empcomm as "Commision" from employee
where empmsal>empcomm;
--5. Display the employees whose job ends with the letter R.
select empno,empname,empjob from employee
where empjob like '%R';
--6. Display the employees that have a name starting with “J”, “K” or “M”.
select empno,empname from employee
where empname like 'J%' or empname like 'K%' or empname like 'M%';
--7. Display the employees who were born before 1960 and earn more than 1500 each month.
select empname from employee
where empbdate < to_date('01-01-1960','dd-mm-yyyy') and empmsal > 1500;
--8. Display the employees that don’t have a commission.
select empname from employee
where empcomm is null;
--9. Display the employee name, job, department name, location and monthly salary of employees that work in New York.
select empname,empjob,d.deptno,d.deptlocation,empmsal from employee e,department d
where e.deptno=d.deptno and deptlocation='NEW YORK';
--10. Display the name and job of employees who do not work in New York or Chicago.
select empname,empjob, deptlocation from employee e,department d
where e.deptno=d.deptno and deptlocation not in('NEW YORK','CHICAGO');--deptlocation not like 'NEW YORK%' and deptlocation not like 'CHICAGO%';
--11. Display the employees who were born in the first half of the 60s. Display the output in birth date order.
select empname,empbdate from employee
where empbdate<to_date('30-Jun-1960','dd-mon-yyyy')
order by empbdate;
--12. Display the employees who earn less than 1500 or greater than 3000 per month.
select empname,empmsal from employee
where empmsal not between 1500 and 3000;--where empmsal<1500 or empmsal>3000;
--13. Display the employees who have a manager.
select empname from employee
where mgrno is not null;
--14. Display the employees who either work in Dallas or as a manager and earn more than 2500.
select empname,d.deptlocation,empjob,empmsal from employee e, department d
where e.deptno=d.deptno and (deptlocation like 'DALLAS' or empjob like 'MANAGER') and empmsal>2500;
--15. Display the name, job, monthly salary and salary grade of all employees. Display the list in monthly salary order within salary grade order.
select empno,empname,empjob,empmsal,salgrade from employee , salgrade 
where empmsal between sallower and salupper  
order by salgrade;
--16. Display the name and location of all departments, and the name of their employees. Display the output in employee name order within department name order.
select deptname,deptlocation,empname from department d,employee e
where d.deptno=e.deptno(+)
order by deptname;
--17. Display the name of all employees, their job and the name of their manager. List the output in employee name order within manager name order.
select m.empname as mgr_name,w.empname as wkr_name,w.empjob from employee w,employee m
where w.mgrno=m.empno(+)
order by mgr_name;
--18. For each employee display their employment history. In the listing include the employees’ name, the name of the department they worked for, the begin and end date and their monthly salary. Display the output in begin date order (most recent at the top of the list) within employee name order.
select empname,deptname,histbegindate,histenddate,histmsal from employee e, history h, department d
where e.empno=h.empno and d.deptno=h.deptno
order by empname;
--19. Display the employee name, empjob, monthly salary and annual salary of all employees.
select empname, empjob, empmsal, empmsal*12 as annual_sal from employee;
--20. Display the employee name, empjob, monthly salary, empcommission and annual income (salary and empcommission) of all employees.
select empname,empjob,empmsal,empcomm, (nvl(empcomm,0)+empmsal)*12 as annual_sal from employee;