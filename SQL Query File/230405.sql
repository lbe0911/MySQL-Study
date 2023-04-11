use sqldb;
-- 기본적인 WHERE절
-- WHERE절은 조회하는 결과에 특정한 조건을 줘서 원하는 데이터만 보고 싶을 때 사용하는데, 다음과 같은 형식을 갖는다.
-- SELECT 필드 이름(열) FROM 테이블 이름 WHERE 조건식
SELECT * FROM usertbl;
SELECT * FROM usertbl WHERE userName = '김경호';

-- 관계 연산자의 사용
-- 1970년 이후에 출생, 신장이 182 이상인 사람의 아이디와 이름 조회
SELECT userID, userName from usertbl where birthYear >= 1970 and height >= 182;
-- 1970년 이후 출생했거나, 신장이 182 상인 사람의 아이디와 이름 조회
SELECT userID, userName FROM usertbl WHERE birthYear >= 1970 or height >=182;

-- BETWEEN AND와 IN() 그리고 LIKE
-- 키가 180 ~ 183인 사람 조회
SELECT * FROM usertbl WHERE height >= 180 and height >= 183;
SELECT * FROM usertbl WHERE height between 180 and 183;
-- *between의 경우 연속형 즉 숫자형에만 가능 연속값이 아니면 사용 불가 ex 경남, 경북
-- 지역이 경남, 전남, 경북인 사람의 정보를 조회
SELECT * FROM usertbl WHERE addr = '경남' or addr = '전남' or  addr = '경북';
-- between 대신에 연속형이아닌 이산적인 값은 IN()을 쓸수 있다.
SELECT * FROM usertbl WHERE addr IN('경남','전남','경북');

-- 문자열의 내용을 검색하기 위해서 LIKE 연산자를 사용할 수 있다,
SELECT userName, height FROM usertbl WHERE userName LIKE '김%';
/* 위 조건은 성은 김 씨이고 그 뒤는 무엇이든 허용한다는 의미다. 김 이 제일 앞 글자인 것들 추출 그리고 한 글자와 매치하기 위해서는 _ 언더바를 사용한다.*/
SELECT userName, height FROM usertbl WHERE userName LIKE '_종신';
/* 이 외에도 % 와 _를 조합해서 사용 가능*/
SELECT userName, height from usertbl where userName like '_용%';

-- ANY/ALL/SOME 그리고 서브쿼리(SubQuery, 하위커리)
-- 서브쿼리란 간단히 얘기하면 쿼리문 안에 또 쿼리문이 있는 것, 예로 김경호보다 키가 크거나 같은 사람의 이름과 키를 출력하려면 WHERE 조건에 김경호의 키를 직접 써야함
SELECT userName, height FROM usertbl WHERE height > 177;
-- 그런데 이 177이라는 키를 직접 써주는 것이 아니라 이것도 쿼리를 통해서 사용하려는 것이다.
SELECT userName, height FROM usertbl WHERE height > (SELECT height FROM usertbl WHERE userName = '김경호');
-- 지역이 경남 사람의 키보다 키가 크거나 같은 사람을 추출
SELECT userName, height FROM usertbl WHERE height >= (SELECT height FROM usertbl WHERE addr = '경남');
-- 위 구문에 1차적으로 문제가 없다. 근데 실행하면 문제가 생긴다 왜냐 하위쿼리가 둘 이상의 값을 반한해서다. (김범수, 윤종신) 이럴때 필요한 구문이 ANY이다.
SELECT userName, height FROM usertbl WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남');
-- 요번엔 any 대신에 all 을 대입
SELECT userName, height FROM usertbl WHERE height >= ALL (SELECT height FROM usertbl WHERE addr = '경남');
-- 7명만 출력 이유는 키는 170보다 크거나 같아야 할 뿐만 아니라, 173보다 크거나 같아야 하기 때문. 결국 173보다 크거나 같은사람만 해당.
-- 결론적으로 ANY는 서브쿼리의 여러 개의 결과 중 한가지만 만족해도 되며, ALL은 서브쿼리의 여러 개의 결과를 모두 만족시켜야 한다. 참고로 SOME은 ANY와 동일한 의미
-- 이번에는 >= ANY 대신에 =ANY를 사용해 보자.
use sqldb;
SELECT userName, height FROM usertbl WHERE height = ANY (SELECT height FROM usertbl WHERE addr = '경남');
-- 정확히 ANY의 다음 서브쿼리 결과와 동일한 값인 173, 170에 해당되는 사람만 출력
SELECT userName, height FROM usertbl WHERE height IN (SELECT height FROM usertbl WHERE addr = '경남');
-- 위 커리는 ANY와 동일한 구문 ANY(서브쿼리) = IN(서브쿼리)와 동일한 의미이다.

-- 원하는 순서대로 정렬여 출력 : ORDER BY
-- order by절은 결과물에 대해 영향을 미치지는 않음. 결과가 출력되는 순서를 조절하는 구문 / 먼저 가입한 순서로 회원들 출력
SELECT userName, mdate FROM usertbl ORDER BY mdate;
-- 기본적으로 오흠차순으로 정렬, 내림차순으로 정렬하려면 열 이름 뒤에 DESC라고 적어주면 된다.
SELECT userName, mdate FROM usertbl ORDER BY mdate DESC;
-- 이번에는 여러 개로 정렬, 키가 큰 순서로 정렬 만약 키가 같을 경우 이름순으로 정렬 ASC는 기본값으로 생략 가능
SELECT userName, height FROM usertbl ORDER BY height DESC, userName ASC;
/* order by에 나온 열이 select 다음에 꼭 있을 필요는 없음. 즉 SELECT userID FROM usertbl ORDER BY height와 같은 구문을 사용해도 된다. 
order by는 어렵지 않은 개념, where절과 같이 사용되어도 무방 그리고 select, from, where, group by, having, order by중에서 제일 뒤에 와야한다.*/
-- 중복된 것은 하나만 남기는 DISTINCT
-- 회원 테이블에서 회원들의 거주지역이 몇 군데인지 출력해 보자
SELECT addr FROM usertbl;
-- 조금 전에 배운 order by절 사용
SELECT addr FROM usertbl ORDER BY addr;
-- 그냥 select 구문보다는 편하지만 세기 귀찮... 만약 몇 만건이면..? 이때 사용하는 구문이 distinct
SELECT DISTINCT addr FROM usertbl;
-- 중복된 것은 1개씩만 보여주면서 출력

-- 출력하는 개수를 제한하는 LIMIT
/* 이번에는 employees DB를 사용. hire_date(회사 입사일)열이 있는데, 입사일이 오래된 직원 5명의 emp_no(사원번호)를 알고 싶다면 어떻게 해야할까? 조금전에 배운
order by절을 사용하면 된다. 먼저 쿼리 창 산단의 행 개수 제한에서 제한 없음을 선택하고 쿼리 실행*/
USE employees;
SELECT hire_date, emp_no FROM employees ORDER BY hire_date ASC;
-- 총 3만개가 넘는다 이중 앞의 5건만 사용하면 되는데 그냥 써도 무방하지만 sql 부담을 준다. 그래서 상위 N개만 출력하는 LIMIT N 구문을 사용.
SELECT hire_date, emp_no FROM employees ORDER BY hire_date ASC LIMIT 5;
-- limit 절은 limit 시작, 개수 또는 limit 개수 offset 시작 형식으로도 사용할 수 있음. 시작은 0부터 그러므로 5개를 출력하기 위해서는 다음과 같이 사용해도 됨.
SELECT emp_no, hire_date FROM employees ORDER BY hire_date ASC LIMIT 0, 5;
SELECT emp_no, hire_date FROM employees ORDER BY hire_date ASC LIMIT 5 OFFSET 0;
-- 위 두개 구문은 동일한 구문

-- 테이블을 복사하는 CREATE TABLE... SELECT
-- CREATE TABLE... SELECT 구문은 테이블을 복사해서 사용할 경우에 주로 사용됨.
/* 형식 :
		CREATE TABLE 새로운테이블 (SELECT 복사할열 FROM 기존 테이블)
다음은 buytbl을 buytbl2로 복사하는 구문*/
USE sqldb;
CREATE TABLE buytbl2 (SELECT * FROM buytbl);
SELECT * FROM buytbl2;
-- 필요하다면 지정한 일부 열만 복사할 수도 있음.
CREATE TABLE buytbl3 (SELECT userID, prodName FROM buytbl);
SELECT * FROM buytbl3;

-- group by 및 having 그리고 집계 함수
-- group by 절
-- 이제는 select 형식 중에서 group by, having절에 대해서 파악해 보자
-- 형식
/* SELECT select_expr
	[FROM table_references]
    [WHERE where_condition]
    [GROUP BY {col_name | expr | position}]
    [HAVING where_condition]
    [ORDER BY {col_name | expr | position] */
    
/* 먼저 GROUP bY 절을 살펴보면, 이 절이 말 그대로 그룹으로 묶어주는 역할을 한다. sqlDB의 구매 테이블에서 사용자가 구매한
물품의 개수를 모려면 다음과 같이 하면 된다.*/
USE sqldb;
SELECT userID, amount FROM buytbl ORDER BY userID;
-- 결과를 보면 사용자별로 여러 번의 물건 구매가 이루어져서 각각의 행이 별도로 출력. BBK 사용자의 경우 19개 구매 합계를 낼때 일일히 다 셀꺼면 뭐하러 sql씀..?
-- 이럴때는 집계함수를 쓰면 된다. 집계함수는 group by절과 함께 쓰이며, 데이터를 그룹화 해주는 기능을 함.
-- 각 사용자(userID)별로 구매한 개수를 합쳐서 출력. 이럴경우 집계함수 sum()과 group by절을 사용하면 됨.
SELECT userID, SUM(amount) FROM buytbl GROUP BY userID;
-- 그런데 sum()의 결과 열에는 제목이 함수 이름 그대로가 나옴. 이럴때 as를 쓰는거임
SELECT userID as '사용자 아이디', SUM(amount) '총 구매 합계' FROM buytbl GROUP BY userID;
-- 이번에는 구매액의 총 합을 구해보자 구매액은 가격 * 수량 총합은 sum을 사용하자
SELECT userID as '사용자 아이디', SUM(amount*price) '총 구매액' FROM buytbl GROUP BY userID;

-- 집계함수
-- sum 외에 group by와 함께 사용되는 집계 함수는 아래와 같다
/* sum : 값을 더하다
   avg : 값의 평균을 구한다.
   min : 최소값을 구한다.
   max : 최대값을 구한다.
   count : 행의 개수를 센다.
   count(distinct) : 행의 개수를 센다.(단 중복은 1개만)
   stdev : 표준편차를 구한다.
   var_samp : 분산을 구한다.*/
   
-- 전체 구매자가 구매한 물품의 개수의 평균을 구해보자.
SELECT AVG(amount) '평균 구매 개수' FROM buytbl;
-- 이번에는 각 사용자 별로 한 번 구매 시 물건을 평균 몇 개 구매했는지 평균을 내보자 GROUP BY 를 사용하면 된다
SELECT userID '사용자 아이디', AVG(amount) '평균 구매 개수' FROM buytbl GROUP BY userID;
-- 다른 예를 살펴보자. 가장 큰 키와 가장 작은 키의 회원 이름과 키를 출력하는 쿼리를 만들어서 직접 실행해보자
SELECT userName '사용자 이름', MAX(height), MIN(height) FROM usertbl GROUP BY userName;
-- 그냥 다나왔다.. 이럴때 써먹는게 서브쿼리이다.
SELECT userName '사용자 이름', height '사용자 키' FROM usertbl WHERE height = (SELECT MAX(height) FROM usertbl) or height = (SELECT MIN(height) FROM usertbl);
-- 이번에는 휴대폰이 있는 사용자의 수를 카운트
SELECT COUNT(*) from usertbl;
-- 휴대폰이 있는 회원만 카운트 하려면 mobile	1을 지정해야한다. 이럴경우 null값을 제외
SELECT COUNT(mobile1) '휴대폰이 있는 사용자' FROM usertbl;

-- HAVING 절
-- 앞에서 했던 sum을 다시 사용해서 사용자별 총구매액을 구해보자.
SELECT userID as '사용자 아이디', SUM(amount) '총 구매 합계' FROM buytbl GROUP BY userID;
-- 그런데 이중에서 1000 이상 사용자에게만 사은품 증정하고 싶다면, 앞에서 배운 조건을 포함하는 where 구문 생각
SELECT userID as '사용자 아이디', SUM(price*amount) '총 구매 합계' FROM buytbl WHERE SUM(price*amount) >= 1000 GROUP BY userID;
-- 오류가 난다. 오류 메세지를 보면 	집계함수는 where절에 나타날수 없다는거 이때 having을 쓴다. 비슷한 개념으로 조건을 제한하는데 집계함수에 대해서 조건은 제한하는것 
-- group by절 다음에 나와야하고, 순서가 바뀌면 안된다.
SELECT userID as '사용자 아이디', SUM(price*amount) '총 구매 합계' FROM buytbl GROUP BY userID HAVING SUM(price*amount) > 1000;
-- 추가로 총 구매액이 적은 사용자부터 나타내려면 order by를 쓰면 된다.
SELECT userID as '사용자 아이디', SUM(price*amount) '총 구매 합계' FROM buytbl GROUP BY userID HAVING SUM(price*amount) > 1000 ORDER BY SUM(price*amount);

-- ROLL UP
-- 총합 또는 중간 합계가 필요하다면 group by 절과 함께 with rollup 문을 사용하면 된다. 만약 분류별로 함계 및 그 총합을 구하고 싶다면 다음의 구문을 사용하자
SELECT num, groupName, SUM(price*amount) as '비용' from buytbl GROUP BY groupName, num WITH ROLLUP;
-- 중간에 num열이 null로 되어 있는 추가된 행이 각 그룹의 소합계를 의미, 또 마지막 행은 각 소합계의 합계 즉 총합계의 결과
-- 위 구문에서 num은 pk이며, 각 항목이 보이는 효과를 위해 넣어준것 만약 소 합계 및 총 합계만 필요하다면 num을 빼면 된다.
SELECT groupName, sum(price*amount) as '비용' FROM buytbl GROUP BY groupName WITH ROLLUP;
