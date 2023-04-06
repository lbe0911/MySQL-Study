-- SQL의 분류
-- SQL문은 크게 DML, DDL, DCL로 분류한다.
-- DML : Data Manipulation Language = 데이터 조작 언어 
/* DML은 데이터를 조작(선택, 삽입, 수정, 삭제)하는 데 사용되는 언어다. DML 구문이 사용되는 대상은 테이블의 행이다.
그러므로 DML을 사용하기 위해서는 꼭 그 이전에 테이블이 정의되어 있어야 한다. SQL문 중에 SELECT, INSERT, UPDATE, DELETE가 이 구문에 해당된다.
또, 트랜잭션이 발생하는 SQL도 이 DML이다.
트랜젝션이란 쉽게 표현하면, 테이블의 데이터를 변경(입력/수정/삭제)할 때 실제 테이블에 완전히 적용하지 않고, 임시로 적용시키는 것을 말한다.
그래서 만약 실수가 있었을 경우에 임시로 적용시키는 것을 말한다. 그래서 만약 실수가 있었을 경우에 임시로 적용시킨 것을 취소시킬 수 있게 해준다.*/

-- DDL : Data Definition Language = 데이터 정의 언어
/* DDL은 데이터베이스, 테이블, 뷰, 인덱스 등의 데이터베이스 개체를 생성/삭제/변경하는 역할을 한다. 자주 사용하는 DDL은 CREATE, DROP, ALTER 등이다.
DDL은 트랜젝션을 발생시키지 않는다. 따라서 되돌림 ROLLBACK이나 완전 적용 COMMIT을 시킬 수가 없다. 즉, DDL문은 실행 즉시 MySQL에 적용된다.*/

-- DCL : Data Control Language = 데이터 제어 언어
/* DCL은 사용자에게 어떤 권한을 부여하거나 빼앗을 때 주로 사용하는 구문으로, GRANT/REVOKE/DENY 등이 이에 해당된다.*/

-- 데이터 변경을 위한 SQL문
/* 데이터의 삽입 : INSERT 문
   INSERT는 테이블에 데이터를 삽입하는 명령어다. 어렵지 않고 간단 기본적인 형식은 다음과 같음.
   INSERT [INTO] 테이블[(열1, 열2, ...)] VALUES (값1, 값2...)
   INSERT문은 어렵지 않고 몇 가지 주의 사항만 알면 된다. 우선 테이블 이름 다음에 나오는 열은 생략이 가능. 생략할 경우 VALUES 다음에 나오는 값들의 순서 및 개수가
   테이블이 정의된 열 순서 및 개수와 동일해야 한다.*/
   USE sqldb;
   CREATE TABLE testTB1 (id int, userName char(3), age int);
   INSERT INTO testTB1 VALUES (1, '홍길동', 25);
   -- 만약 위의 예에서 id와 이름만 입력하고 나이를 입력하고 싶지 않다면 다음과 같이 테이블 이름 뒤에 입력할 열의 목록을 나열해줘야 함.
   INSERT INTO testTB1(id, userName) Values (2, '설현');
   /* 이 경우 생략한 age에는 NULL값이 들어간다.
      열의 순서를 바꿔서 입력하고 싶을 때는 꼭 열 이름을 입력할 순서에 맞춰 나열해 줘야 한다.*/
INSERT INTO testTB1(userName, id, age) Values('하니', 2, 30);
SELECT * FROM testTB1;

-- 자동으로 증가하는 AUTO_INCREMENT
/* 테이블의 속성이 AUTO_INCREMENT로 지정되어 있다면, INSERT에서는 해당 열이 없다고 생각하고 입력하면 된다. AUTO_INCREMENT는 자동으로 1부터 증가하는 값을
   입력해 준다. AUTO_INCREMENT로 지정할 때는 꼭 PK 또는 UNIQUE로 지정해 줘야 하며 데이터 형은 숫자 형식만 사용할 수 있다. AUTO_INCREMENT로 지정된 열은
   INSERT문에서 NULL값을 지정하면 자동으로 값이 입력된다.*/
CREATE TABLE testtbl2(id int AUTO_INCREMENT PRIMARY KEY, userName char(3), age int);
INSERT INTO testtbl2 VALUES (NULL, '지민', 25);
INSERT INTO testtbl2 VALUES (NULL, '유나', 22);
INSERT INTO testtbl2 VALUES (NULL, '유경', 21);
SELECT * FROM testtbl2;
/* 계속 입력을 하다 보면 현재 어느 숫자까지 증가되었는지 확인할 필요도 있다. SELECT LAST_INSERT_ID(); 쿼리를 사용하면 마지막에 입력된 값을 보여준다. 이 경우에는
   3을 보여줄 것이다. 그런데, 이후에는 AUTO_INCREMENT 입력값을 100 부터 입력되도록 변경하고 싶다면 다음과 같이 수행하면 된다.*/
ALTER TABLE testtbl2 AUTO_INCREMENT=100;
INSERT INTO testtbl2 VALUES (NULL, '찬미', 23);
SELECT * FROM testtbl2;
-- 증가값을 지정하려면 서버 변수인 @@AUTO_INCREMENT_INCREMENT변수를 변경시켜야 한다. 다음 예제는 초깃값을 1000으로 하고 증가값은 3으로 변경하는 예제
CREATE TABLE testtbl3
(id int AUTO_INCREMENT PRIMARY KEY,
 userName char(3),
 age int);
 ALTER TABLE testtbl3 AUTO_INCREMENT=1000;
 SET @@auto_increment_increment=3;
 INSERT INTO testtbl3 VALUES(NULL, '나연', 20);
 INSERT INTO testtbl3 VALUES(NULL, '정연', 23);
 INSERT INTO testtbl3 VALUES(NULL, '모모', 19);
 SELECT * FROM testtbl3;
-- 여기서 Tip 한꺼번에 INSERT
-- 여러 개의 행을 한꺼번에 입력할 수도 있다. 3건을 입력하기 위해서 지금까지 3개의 문장으로 입력했었는데, 3건의 데이터를 한 문장에서 다음과 같이 입력할 수도 있다.
-- INSERT INTO 테이블이름 VALUES (값1, 값2), (값3, 값4), (값5, 값6);

-- 대량의 샘플 데이터 생성
/* 샘플 데이터를 입력하는 경우를 생각해보면, 지금까지 했던 방식으로 입력하면 많은 시간이 걸린다. 이럴때 insert into ... select 구문을 사용할 수 있다. 이는
   다른 테이블의 데이터를 가져와서 대량으로 입력하는 효과를 낸다.
   형식 : insert into 테이블이름 (열 이름1, 열 이름2, ...)
         select문 ;
   물론, select문의 결과 열의 개수는 insert를 할 테이블의 열 개수와 일치해야 한다. employees의 데이터를 가져와서 입력해 보자.*/
CREATE TABLE testtbl4 (id int, Fname varchar(50), Lname varchar(50));
INSERT INTO testtbl4
	SELECT emp_no, first_name, last_name
    FROM employees.employees ;
/* 이렇듯 기존의 대량의 데이터를 샘플 데이터로 사용할 때 INSERT INTO ... SELECT문은 아주 유용하다. 아예, 테이블 정의까지 생략하고 싶다면 앞에서 배웠던
   CREATE TABLE ... SELECT 구문 다음과 같이 사용할 수도 있다.*/
CREATE TABLE testtbl5
	(SELECT emp_no, first_name, last_name FROM employees.employees);
SELECT * FROM testtbl5;
   