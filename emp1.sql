create table dept(deptno number(2), dname  varchar2(20), loc  varchar2(15),  
constraint pk_dept primary key (deptno));
 
create table emp(empno  number(4), ename varchar2(10), job varchar2(9), mgr number(4), hiredate date,
sal number(7,2), comm number(7,2), deptno number(2), constraint pk_emp primary key (empno),
constraint fk_deptno foreign key (deptno) references dept (deptno));

insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');

insert into emp values(7839, 'KING', 'PRESIDENT', null, to_date('17-11-1981','dd-mm-yyyy'), 5000, null, 10);
insert into emp values(7698, 'BLAKE', 'MANAGER', 7839, to_date('1-5-1981','dd-mm-yyyy'), 2850, null, 30);
insert into emp values(7782, 'CLARK', 'MANAGER', 7839, to_date('9-6-1981','dd-mm-yyyy'), 2450, null, 10);
insert into emp values(7566, 'JONES', 'MANAGER', 7839, to_date('2-4-1981','dd-mm-yyyy'),  2975, null, 20);
insert into emp values(7788, 'SCOTT', 'ANALYST', 7566, to_date('13-7-1987','dd-mm-yyyy'), 3000, null, 20);
insert into emp values(7902, 'FORD', 'ANALYST', 7566, to_date('3-12-1981','dd-mm-yyyy'),  3000, null, 20);
insert into emp values(7369, 'SMITH', 'CLERK', 7902, to_date('17-12-1980','dd-mm-yyyy'), 800, null, 20);
insert into emp values(7499, 'ALLEN', 'SALESMAN', 7698, to_date('20-2-1981','dd-mm-yyyy'),1600, 300, 30);
insert into emp values(7521, 'WARD', 'SALESMAN', 7698, to_date('22-2-1981','dd-mm-yyyy'), 1250, 500, 30);
insert into emp values(7654, 'MARTIN', 'SALESMAN', 7698, to_date('28-9-1981','dd-mm-yyyy'), 1250, 1400, 30);
insert into emp values(7844, 'TURNER', 'SALESMAN', 7698, to_date('8-9-1981','dd-mm-yyyy'), 1500, null, 30);
insert into emp values(7876, 'ADAMS', 'CLERK', 7788, to_date('13-7-1987', 'dd-mm-yyyy'), 1100, null, 20);
insert into emp values(7900, 'JAMES', 'CLERK', 7698, to_date('3-12-1981','dd-mm-yyyy'), 950, null, 30);
insert into emp values(7934, 'MILLER', 'CLERK', 7782, to_date('23-1-1982','dd-mm-yyyy'),1300, null, 10);
--1) Display all the records in emp table.
select * from emp;
--2) Display all the records in emp table where employee belongs to deptno 10.
select * from emp where deptno=10;
--3) Display all the records in emp table where employee does not belong to deptno 30.
select * from emp where deptno!=30;
--4) Display total number of records in Emp table.
select count(*) as total from emp;
--5) Display emp table with salary descending order.
select * from emp order by sal desc;
--) Display first five records in employee table.
--7) Display all the records in emp table order by ascending deptno, descending salary.
select * from emp order by deptno asc,sal desc;
--8) Display all employees those who were joined in year 1981.
select * from emp where hiredate like '%81';
--10) Display the records in emp table where MGR in 7698,7566 and sal should be greater then 1500
select * from emp where mgr in(7698,7566) and sal > 1500;
--11) Display all employees where their salary is less then the Ford’s salary?
select * from emp where sal < (select sal from emp where ename='FORD');
--12) Display all the records in EMP table along with the rowid.
--13) Write a query to display current date.

--14) Display distinct job from emp table.
select distinct job from emp;
--15) Write a query that displays the employee’s names with the first letter capitalized and all other letters lowercase for all employees whose name starts with J, A, or M.
select concat(upper(substr(ename,1,1)),lower(substr(ename,2))) as name 
      from emp
     where (upper(substr(ename,1,1))) in ('J','A','M');
--16) Write a query to display the employee name, department name of all employees who earn a commission.
select ename,dname from emp natural join dept where comm is not null;
--17) Display the empno, ename, sal, and salary increased by 15%.
select empno,ename,sal,(sal+sal*0.15) as newsal from emp;
--18) Display employee names and corresponding manager names
select e1.ename as emp , e2.ename as mgr
    from emp e1,emp e2
  where  e1.mgr = e2.empno;
--19) Display all the departments where employee salary greater than average salary of that department.
select dname,deptno
    from dept
     where deptno in (select deptno  from emp group by deptno having max(sal)>avg(sal));
--20) Display employees where length of ename is 5
select * from emp where length(ename)=5;
--21) Display all employees where ename start with J and ends with S
select * from emp where ename like 'J%S';
--22) Display all employees where employee does not belong to 10,20,40
select * from emp where deptno not in(10,20,40);
--23) Display all employees where jobs does not belong to PRESIDENT and MANAGER.
select * from emp where job not in('PRESIDENT','MANAGER');
--24) Display the maximum salary in the emp table
select max(sal) from emp 
--25) Display average salary for job SALESMAN
select avg(sal) from emp where job = 'SALESMAN';
--26) Display all ename where first character could be anything, but second character should be L.
select ename from emp where ename like '_L%' or ename like '_l%';
--27) Display nth highest and nth lowest salary in emp table.
select max(sal) as max,min(sal) as min from emp;
--28) Display all the departments where department has 3 employees.
select dname from dept
   where deptno in(select deptno from emp group by deptno having count(*)=3);
--29) Display sum of salary for each department.
select sum(sal),deptno from emp group by deptno;
--30) Display all department with Minimum salary and maximum salary?
select max(sal),min(sal) from emp group by deptno;
