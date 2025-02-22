/* ********************************************************************************
조인(JOIN) 이란(필수!!!)
- 2개 이상의 테이블에 있는 컬럼들을 합쳐서 가상의 테이블을 만들어 조회하는 방식을 말한다.
 	- 소스테이블 : 내가 먼저 읽어야 한다고 생각하는 테이블(메인정보 테이블)
	- 타겟테이블 : 소스를 읽은 후 소스에 조인할 대상이 되는 테이블(추가정보 테이블)
 
- 각 테이블을 어떻게 합칠지를 표현하는 것을 조인 연산이라고 한다.
    - 조인 연산에 따른 조인종류
        - Equi join , non-equi join
        - 
- 조인의 종류
    - Inner Join 
        - 양쪽 테이블에서 조인 조건을 만족하는 행들만 합친다. 
    - Outer Join
        - 한쪽 테이블의 행들을 모두 사용하고 다른 쪽 테이블은 조인 조건을 만족하는 행만 합친다. 조인조건을 만족하는 행이 없는 경우 NULL을 합친다.
        - 종류 : Left Outer Join,  Right Outer Join, Full Outer Join
    - Cross Join
        - 두 테이블의 곱집합을 반환한다. 
******************************************************************************** */        
use hr_join;


/* ****************************************
-- INNER JOIN
FROM  테이블a INNER JOIN 테이블b ON 조인조건 

- inner는 생략 할 수 있다.
**************************************** */

-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
select *
from emp join dept on dept.dept_id = emp.dept_id; -- inner 생략 가능.

select *
from emp e join dept d on d.dept_id = e.dept_id; -- 테이블 이름의 길이가 길어서 별칭 부여 ex) from emp e join dept d on 

-- emp테이블과 dept테이블을 합친다. emp.dept_id값과 dept.dept_id가 같은 행끼리 합쳐라(한 행으로 합쳐라)
select *
from emp e join dept d on e.dept_id = d.dept_id;

-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회.
select e.emp_id
,e.emp_name
,e.hire_date
,d.dept_name
from emp e join dept d on e.dept_id = d.dept_id
where e.emp_id = 100;

-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회
select e.emp_id, e.emp_name, e.salary,
j.job_title,
d.dept_namejobempdept
from emp e join job j on e.job_id = j.job_id
			join dept d on e.dept_id =d.dept_id;


-- 부서_ID(dept.dept_id)가 30인 부서의 이름(dept.dept_name), 위치(dept.loc), 그 부서에 소속된 직원의 이름(emp.emp_name)을 조회.
select d.dept_name, d.loc,e.emp_name, d.dept_id
from emp e join dept d on e.dept_id = d.dept_id
where d.dept_id = 30;

select*from dept;
select*from emp;

-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 급여등급(salary_grade.grade) 를 조회. 급여 등급 오름차순으로 정렬
select e.emp_id, e.emp_name, e.salary,
concat(s.grade, '레벨')
from emp e join salary_grade s on salary between s.low_sal and s.high_sal; -- salary는 emp의 것인데 salary_grade 를 emp e와 연결시킨다.


-- TODO 직원 id(emp.emp_id)가 200번대(200 ~ 299)인 직원들의  
-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 내림차순으로 정렬.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e join dept d on e.dept_id = d.dept_id
where e.emp_id between 200 and 300 order by e.emp_id desc;

-- TODO 업무(emp.job_id)가 'FI_ACCOUNT'인 직원의 ID(emp.emp_id), 이름(emp.emp_name),
-- 업무(emp.job_id), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 내림차순으로 정렬.
select e.job_id
,e.emp_id
,e.emp_name
,d.dept_name
,d.loc
from emp e join dept d on e.dept_id = d.dept_id
where e.job_id = "FI_ACCOUNT" order by e.emp_id desc;

-- TODO 커미션을(emp.comm_pct) 받는 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name),
-- 급여(emp.salary), 커미션비율(emp.comm_pct), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 내림차순으로 정렬.
select ifnull(e.comm_pct, '1')
,e.emp_id
,e.emp_name
,e.salary
,d.dept_name
,d.loc
from emp e join dept d on e.dept_id = d.dept_id
order by e.emp_id desc;

-- TODO 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
-- 그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 
select d.loc, d.dept_id, d.dept_name, e.emp_id, e.emp_name, e.job_id
from emp e join dept d on e.dept_id = d.dept_id
where d.loc = 'New York';


-- TODO 직원_ID(emp.emp_id), 이름(emp.emp_name), 업무_ID(emp.job_id), 업무명(job.job_title) 를 조회.
select e.emp_id, e.emp_name, e.job_id, j.job_title
from emp e join job j on e.job_id = j.job_id;
   
      
-- TODO: 직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회              
select e.job_id, e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e join job j on e.job_id = j.job_id
           join dept d on e.dept_id = d.dept_id
where e.job_id = 200;


-- TODO: 'San Francisco' 에 근무(dept.loc)하는 직원의 id(emp.emp_id), 
-- 이름(emp.emp_name), 입사일(emp.hire_date)를 조회 입사일은 'yyyy년 mm월 dd일' 형식으로 출력
-- date_format(now(),'%y년 %m월 %d일 %h시 %i분 %s초 %W %p')
select d.loc, e.emp_id, e.emp_name, date_format(e.hire_date, '20%y %m %d')
from emp e join dept d on e.dept_id = d.dept_id
where d.loc = 'San Francisco';

select hire_date from emp;


-- TODO 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬. 
select d.dept_name, avg(e.salary)
from emp e join dept d on e.dept_id = d.dept_id
group by d.dept_name
order by avg(e.salsalary_gradeempempary) desc;

select d.dept_name, e.salary
from emp e join dept d on e.dept_id = d.dept_id;

-- TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 
-- 급여(emp.salary), 급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회. 등급 내림차순으로 정렬
select e.emp_id, e.emp_name, j.job_title, s.grade
from emp e join job j on e.job_id = j.job_id
           join salary_grade s on salary between s.low_sal and s.high_sal
		   join dept d on e.dept_id = d.dept_id
order by s.grade desc;


/* ****************************************************
Self 조인
- 물리적으로 하나의 테이블을 두개의 테이블처럼 조인하는 것.
**************************************************** */
-- ex) HR_join_tables => emp 참조.

-- 직원 ID가 101인 직원의 직원의 ID(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name)을 조회
select e.emp_id, e.emp_name, m.emp_name from emp e join emp m on e.mgr_id = m.emp_id
where e.emp_id =101;

select * from emp;



/* ****************************************************************************
외부 조인 (Outer Join)
- 불충분 조인
    - 조인 연산 조건을 만족하지 않는 행도 포함해서 합친다
종류
 left  outer join: 구문상 소스 테이블이 왼쪽
 right outer join: 구문상 소스 테이블이 오른쪽
 full outer join:  둘다 소스 테이블 (Mysql은 지원하지 않는다. - union 연산을 이용해서 구현)

- 구문
from 테이블a [LEFT | RIGHT] OUTER JOIN 테이블b ON 조인조건
- OUTER는 생략 가능.
- 오라클 조인 문법.
 select e.emp_name, d.dept_name
 from emp e, dept d
 where e.dept_id = d.dept_id
 and 추가조건;
**************************************************************************** */


-- 직원의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 부서명(dept.dept_name), 부서위치(dept.loc)를 조회. 
-- 부서가 없는 직원의 정보도 나오도록 조회. dept_name의 내림차순으로 정렬한다.

select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e  left outer join dept d on e.dept_id = d.dept_id
order by d.dept_name desc;


-- 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 부서_id(emp.dept_id)를 조회하는데
-- 부서_id가 80 인 직원들은 부서명(dept.dept_name)과 부서위치(dept.loc) 도 같이 출력한다. (부서 ID가 80이 아니면 null이 나오도록)
select e.emp_id, e.emp_name, e.dept_id, d.dept_name, d.loc
from emp e left join dept d on e.dept_id = d.dept_id 
and e.dept_id = 80;
-- where d.dept_id is null;
-- 175	Alyssa			
-- 178	Kimberely			
-- 183	Girard			
-- 184	Nandita			
-- 185	Alexis			
        
-- TODO: 직원_id(emp.emp_id)가 100, 110, 120, 130, 140인 
--  직원의 ID(emp.emp_id),이름(emp.emp_name), 업무명(job.job_title) 을 조회. 업무명이 없을 경우 '미배정' 으로 조회



-- TODO: 부서 ID(dept.dept_id), 부서이름(dept.dept_name)과 그 부서에 속한 직원들의 수를 조회. 직원이 없는 부서는 0이 나오도록 조회하고 직원수가 많은 부서 순서로 조회.



-- TODO: EMP 테이블에서 부서_ID(emp.dept_id)가 90 인 모든 직원들의 id(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name), 입사일(emp.hire_date)을 조회. 
-- 입사일은 yyyy/mm/dd 형식으로 출력


-- TODO 2003년~2005년 사이에 입사한 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 입사일(emp.hire_date),
-- 상사이름(emp.emp_name), 상사의입사일(emp.hire_date), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.

SELECT e.emp_id, e.emp_name, j.job_title, e.salary, e.hire_date, m.emp_name "상사 이름", m.hire_date "상사 입사일", d.dept_name, d.loc
FROM emp e
	JOIN emp m
		ON e.mgr_id = m.emp_id
	LEFT JOIN job j
		ON e.job_id = j.job_id
	LEFT JOIN dept d
		ON e.dept_id = d.dept_id
			WHERE year(e.hire_date) 
				BETWEEN 2003 AND 2005
					ORDER BY 1 ASC;



SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM job;
SELECT * FROM emp e JOIN emp m ON e.mgr_id = m.emp_id;









