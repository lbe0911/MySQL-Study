-- staff 사용자 생성 권한 부여
create user staff/*사용자 이름 */@'%'identified by 'qud!'/*사용자 비번*/;
grant select, insert, update, delete on shopDB.*to staff@'%'; /*shopDB 데이터베이스 select, delete, insert, update 권한 부여*/
grant select on employees.*to staff@'%';/*employees 데이터베이스 select 권한 부여*/
-- 쿼리문 실행
select * from employees; -- 가능
create database sampleDB; -- 불가능(권한 없음)
drop database sampleDB; -- 불가능(권한 없음)


-- director 사용자 생성 권한 부여
create user director@'%'identified by 'qud!';
grant all on *.* to director@'%'with grant option; -- 모든 권한 부여
-- 쿼리문 실행
select * from employees; -- 가능
create database sampleDB; -- 가능
drop database sampleDB; -- 가능

-- SELECT문
-- 많이 사용하고 요약된 구조 []<- 대괄호 안 내용은 생략할 수 있음.
SELECT /*열 이름*/ * (모든것) 모든 열 / 필요하는 열만 가져올때 열 이름 입력 name / 여러개 가져오고 싶을때는 ,(콤마) 사용해서 사용할 열 입력
FROM /* 테이블 이름 */ employees
WHERE /*조건*/ name = 'minzi'
GROUP BY /*col_name / expr / position*/ gender
HAVING /*조건*/
ORDER BY /* col_name / expr / position*/ ;

-- USE 구문 : 데이터베이스 지정 또는 변경
USE /*데이터베이스 이름*/ employees;

/* 실습 1 : 데이터베이스 이름, 테이블 이름, 필드 이름이 정확히 기억나지 않거나 또는 각 이름의 철자가 확실하지 않을 때 찾아서 조회하는 방법을 실습하자.
지금 조회하고자 하는 내용이 employees 데이터베이스에 있는 employees 테이블의 first_name 및 gender열이라고 가정한다.*/
use employees;
show tables; -- 현재 데이터 베이스에 있는 테이블 보여줘
describe employees; -- 현재 테이블에 있는 열 보여줘
select first_name, gender from employees; -- employees 테이블에서 first_name과 gender 열을 보여줘
/* 팁 : 열 이름의 별칭 열 이름을 별도의 별칭(alias) 줄여서 as 형식으로 사용 하지만, 별칭에 중간 공백이 있다면 꼭 ''따옴표로 감싸줘야 한다. 또한 as는 생략해도 된다.
아래 예시 구문*/
select first_name as f_name, gender 성별, hire_date '회사 입사일' from employees;

-- 실습 2 : 전 과정에서 사용할 데이터베이스와 테이블 생성
/*1. DB만들기*/ CREATE DATABASE sqldb;
use sqldb;
/*2. 테이블 만들기*/ CREATE TABLE usertbl -- 회원 테이블
(userID CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK) 고유값
userName VARCHAR(10) NOT NULL,
birthYear INT NOT NULL,
addr CHAR(2) NOT NULL, -- 지역 경기, 서울, 경남 식으로 2글자 입력
mobile1 CHAR(3), -- 휴대폰 국번 010
mobile2 CHAR(8), -- 하이픈 제외 나머지 번호
height SMALLINT, -- 키
mDate DATE -- 회원 가입일
);
CREATE TABLE buytbl -- 회원 구매 테이블
( num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
userID CHAR(8) NOT NULL, -- 아이디(FK)
prodName CHAR(6) NOT NULL, -- 물품명
groupName CHAR (4), -- 분류 
price INT NOT NULL, -- 단가
amount SMALLINT NOT NULL, -- 수량
FOREIGN KEY (userID) REFERENCES usertbl(userID)
);
-- 3. 데이터 입력
INSERT INTO usertbl VALUES('LSG', '이승기' , 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수' , 1987, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호' , 1987, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필' , 1987, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경' , 1987, '서울', NULL, NULL, 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범' , 1987, '서울', '016', '66666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신' , 1987, '경남', NULL, NULL, 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원' , 1987, '경북', '011', '88888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우' , 1987, '경기', '018', '99999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴' , 1987, '서울', '010', '01234567', 176, '2013-5-5');
INSERT INTO buytbl VALUES(NULL, 'KBS' , '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS' , '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP' , '모니터', '전자', 200, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK' , '모니터', '전자', 200, 5);
INSERT INTO buytbl VALUES(NULL, 'KBS' , '청바지', '의류', 50, 3);
INSERT INTO buytbl VALUES(NULL, 'BBK' , '메모리', '전자', 80, 10);
INSERT INTO buytbl VALUES(NULL, 'SSK' , '책', '서적', 15, 5);
INSERT INTO buytbl VALUES(NULL, 'EJW' , '책', '서적', 15, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW' , '청바지', '의류', 50, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK' , '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW' , '책', '서적', 15, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK' , '운동화', NULL, 30, 2);

-- 데이터 확인
SELECT * FROM usertbl;
SELECT * FROM buytbl;


