# MySQL-Study


## SQL 공부를 위해 이것이 MySQL(개정판)을 선정하여 Study 진행
---

## SQL 기본(p.181)
### 1. SELECT 문
    - 원하는 데이터를 가져와 주는 기본적이고 많이 사용하는 구문
    - 형식 : SELECT select_expr(출력할 열)
            [FROM table_references(사용할 테이블 명)]
            [WHERE where_condition(조건)]
            [GROUP BY {col_name|expr|position}]
            [HAVING where_condition(조건)]
            [ORDER BY {col_name|expr|position}]
            여기서 [] 대괄호의 내용은 생략할 수 있다.
    - 위 형식중 가장 자주 쓰이는 형식을 뽑자면
            * SELECT 열 이름
              FROM 테이블 이름
              WHERE 조건 이렇게 3가지로 뽑을 수 있다.

### 2. USE 구문
    - SELECT 문을 사용전 사용할 데이터베이스를 먼저 지정해야한다. 안그러면 다른 데이터베이스를 사용할 수 있기 때문이다.
    - 형식 : USE 데이터베이스_이름 ;
        예) USE employees ;
        * USE구문을 다른 데이터베이스로 다시 지정전까지 계속 사용 가능

### 3. SELECT와 FROM
    - 형식 : SELECT * FROM titles ;
    - 위 형식에서 SELECT 뒤 *은 모든것을 의미. 즉 모든열을 선택 FROM 뒤는 테이블 또는 뷰등의 항목. 
      풀이하자면 'titles 테이블에서 모든열의 내용을 가져와라' 이다.
    - 동일한 형식으로 SELECT * FROM employees.titles; 이다. 원래 테이블의 전체 이름은 '데이터베이스이름.테이블이름' 
      형식으로 표현하지만, 생략하더라도 선택된 데이터베이스 이름이 자동으로 붙게되어 쿼리가 실행된다.
    - 필요한 열만 선택해서 가져오고 싶을경우, 선택할 열 이름을 입력, 여러 개의 열을 가져오고 싶으면 콤마(,)로 구분해서 입력하면 된다.
* Tip
    - 주석 '--'쓰고 한칸 띄어서 글 입력 <- 한줄 주석만 가능, /* ... */ <- 여러줄 주석 가능. 주석으로 묶이면 해당 글자는 회색으로 보인다.
    - SHOW DATABASE : 현재 서버에 어떤 데이터베이스가 있는지 조회
    - SHOW TABLE STATUS : 현재의 데이터베이스에 있는 테이블의 정보 조회
      테이블 이름만 간단히 보려면 SHOW TABLE ; 사용
    - 테이블의 열이 무엇이 있는지 확인 DESCRIBE 테이블이름, DESC 테이블이름
    - 열 이름을 별칭으로 지정할수 있다. Alias = AS 또는 생략 후 띄어쓰기.  
      예) SELECT first_name AS 성, last_name 이름...
      이때 별칭 중간에 공백이 생긴다면 ''를 써야한다.
      예) SELECT hire_date AS '회사 입사일'

### 4. 기본적인 WHERE 절
    - WHERE절은 조회하는 결과에 특정한 조건을 줘서 원하는 데이터만 보고 싶을 때 사용한다.
    - 형식 : SELECT * FROM usertbl WHERE 조건식;
    - 예시 : SELECT * FROM usertbl WHERE name = '김경호';
    - 관계연산자 사용
        - 1970년 이후 출생하고 신장 182이상인 사람 아이디, 이름 조회
        SELECT userName, userID FROM usertbl WHERE birthYear >= 1970 AND height >= 182;
        - 1970년 이후 출생했거나 신장 182이상인 사람 아이디, 이름 조회
        SELECT userName, userID FROM usertbl WHERE birthYear >= OR height >= 182 ;
        ~했거나, -또는 등 = OR / ~하고, ~면서, ~그리고 등 = AND 연산자
### 5. BETWEEN..A AND B와 IN() 그리고 LIKE
#### 5.1. BETWEEN..A AND B
    - 예를 들어 키가 180 ~ 183인 사람을 조회해 볼때
    SELECT userName, height FROM usertbl WHERE height >= 180 AND height <= 183 ;
    - 위 쿼리와 동일한 방식으로 사용할 수 있다.
    SELECT userName, height FROM usertbl WHERE height BETWEEN 180 AND 183 ;
    - 키의 경우 숫자로 구성, 연속적인 값 BETWEEN AND 사용이 가능함. But 지역이나 사람을 찾는 연속된 값이 아닐때는 사용이 불가.
#### 5.2. IN()
    - 지역이 경남, 전남, 경북인 사람의 정보를 확인
    SELECT userName FROM usertbl WHERE addr = '경남' OR addr = '전남' OR addr = '경북' ;
    - 위 쿼리와 같이 연속이 아닌 이산적인 값을 위해 IN()을 사용할 수 있음.
    SELECT userName FROM usertbl WHERE addr IN('경남', '경북', '전남');
#### LIKE
    - 문자열의 내용을 검색하기 위해서 LIKE 연산자를 사용할 수 있음.
    SELECT userName, height FROM usertbl WHERE userName LIKE '김%';
    - 위 쿼리는 성이 김씨이고 그 뒤는 무엇이든 상관없음을 의미. 즉 김이 맨 앞 글자인 것들을 추출 그리고 한 글자와 매치하기 위해서는 '_' 이용
    SELECT userName, height FROM user WHERE userName LIKE '_종신'; -> 이름이 종신인 사람 추출
    SELECT userName, height FROM user WHERE userName LIKE '_용%'; -> 아무거나 한 글자 + 용 + 몇 글자 상관없는 아무거나

### 6. ANY, ALL, SOME 그리고 서브쿼리(SubQuery)
#### 6.1. 서브쿼리    
    - 서브쿼리란 간단히 얘기하면 쿼리문 안에 또 쿼리문이 있는 것.
      예로 김경호보다 키가 크거나 같은 사람의 이름과 키를 출력하려면 WHERE 조건에 김경호의 키(177)를 직접 써줘야 한다.
      SELECT userName, height FROM usertbl WHERE height > 177 ;
      이 177이라는 키를 직접 써주는 것이 아닌 쿼리를 통해 사용하려는 것
      SELECT userName, height FROM usertbl WHERE height > (SELECT userName FROM usertbl WHERE userName = '김경호');
      후반부 (SELECT ~ WHERE userName = '김경호')sms 177이라는 값을 돌려주니 결국 177이라는 값이 되어 꼭 177을 직접 써주지 않아도 된다는 것.
#### 6.2. ANY / ALL / SOME
    - ANY는 서브쿼리의 여러 개의 결과 중 한가지만 만족해도 되는데, ALL은 여러 개의 결과를 모두 만족시켜야 한다. 참고로 ANY = SOME 동일한 의미
    - 6.1 쿼리를 사용해서 지역이 경남 사람의 키보다 키가 크거나 같은 사람을 추출할 때
      SELECT userName, height FROM usertbl WHERE addr >= (SELECT height FROM usertbl WHERE addr = '경남');
      위 쿼리를 실행하면 오류 발생. 왜? 서브쿼리가 둘 이상의 값을 반환해서
      이럴때 ANY를 사용하는것
      SELECT userName, height FROM usertbl WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남');
      키가 173, 170보다 크거나 같은 사람이 모두 출력. 결국 키가 170보다 크거나 같은 사람이 출력
      ANY를 ALL로 바꿔보면 170, 173보다 크거나 같아야 하기 때문에 결국 173보다 크거나 같은 사람만 해당되어 출력
      이번에는 >= ANY 대신 = ANY를 사용
      SELECT userName, height FROM usertbl WHERE height = ANY(SELECT height FROM usertbl WHERE addr = '경남');
      서브쿼리 값인 170, 173에 해당되는 사람만 출력 이는 IN()과 같음.
      SELECT userName, height FROM usertbl WHERE height IN(SELECT height FROM usertbl WHERE addr = '경남');

### 7. 원하는 순서대로 정렬하여 출력 : ORDER BY
    - ORDER BY절은 결과물에 대해 영향을 미치지는 않지만, 결과가 출력되는  순서를 조절하는 구문. 예를들어 가입한 순서로 회원들을 출력 쿼리는
    SELECT userName, mdate FROM usertbl ORDER BY mdate ;
    - 기본적으로 오름차순으로 정렬. 내림차순으로 정렬하고 싶으면
    SELECT userName, mdate FROM usertbl ORDER BY mdate DESC ; 열 이름 뒤에 DESC를 적어주면 된다.
    - 여러 개로 정렬 할 경우, 키가 큰 순서로 정렬 동일할 경우 이름순 정렬
    SELECT userName, height FROM usertbl ORDER BY height DESC, userName ASC; <- ASC는 디폴트 값이라 생략 가능
    - ORDER BY 절은 SELECT FROM WHERE GROUP BY HAVING 제일 뒤에 와야 한다. 또 WHERE절과 같이 사용해도 무방하다.

### 8. 중복된 것은 하나만 남기는 DISTINCT
    - 회원 테이블에서 회원들의 거주지역이 몇 군데인지 출력
    SELECT addr FROM usertbl;
    - 중복되는 값 까지 출력되는데 많을경우 세는게 어려울 수 있다. 이럴때 사용하는게 DISTINCT이다.
    SELECT DiSTINCT addr FROM usertbl; <- 중복은 제거 1개씩 출력

### 9. 출력하는 개수를 제한하는 LIMIT
    - 입사일이 오래된 직원 5명을 출력하고 싶을때 LIMIT 사용
    SELECT emp_no, hire_date FROM employees ORDER BY hire_date LIMIT 5;
    - LIMIT절은 LIMIT N, LIMIT 시작, 개수 또는 LIMIT 개수 OFFSET 시작 형식으로도 사용할 수 있다. 시작은 0부터 시작

### 10. 테이블을 복사하는 CREATE TABLE ... SELECT
    - CREATE TABLE ... SELECT 구문은 테이블 복사해서 사용할 경우 사용
    - 형식 : CREATE TABLE 새로운테이블 (SELECT 복사할 열 FROM 기존 테이블)
    - buytbl중 userName을 buytbl2로 복사하는 구문
    CREATE TABLE buytbl2(SELECT userName FROM usertbl);

### 11. GROUP BY 및 HAVING 그리고 집계 함수
#### GROUP BY절
    - 말 그대로 그룹으로 묶어주는 역할을 함. 또한 집계 함수도 같이 사용한다.
    SELECT userID, SUM(amount) FROM buytbl GROUP BY userID ;
    예를 들어 구매액의 총합을 구할경우 가격 * 수량 이니까 SUM()에 가격 * 수량을 넣어주면 된다.
    SELECT userID, SUM(price * amount) FROM buytbl GROUP BY userID ;
#### 집계 함수
    - GROUP BY와 함께 주로 사용하는 집계 함수는 아래 참고
    - AVG() : 평균 / MIN() : 최소값 / MAX() : 최대값 / COUNT() : 개수 / COUNT(DISTINCT) : 중복제거 개수 / STDEV() : 표준편차 / VAR_SAMP() : 분산
    - 이중 가장 큰 키와 작은 키의 회원 이름과 키를 출력하는 쿼리를 작성
    SELECT userName, MIN(height), MAX(height) FROM usertbl;
    결과는 가장 큰 키와 작은 키 나왔지만, 이름은 하나뿐이라서 어떤것에 해당되는지 알수가 없음. GROUP BY를 활용해서 수정해보면
    SELECT userName, MIN(height), MAX(height) FROM usertbl GROUP BY userName; 모든 결과가 다 나와버림...
    이럴때는 서브쿼리를 사용하는 것이 좋다.
    SELECT userName, height FROM usertbl WHERE height = (SELECT MIN(height) FROM usertbl) or height(SELECT MAX(height) FROM usertbl);
#### HAVING절
    - HAVING은 WHERE와 비슷한 개념으로 조건을 제한하는 것이지만 짐계함수에 대해서 조건을 제한하는 것이라고 생각하면 된다. 그리고 GROUP BY절 다음에 나와야 한다. 순서가 바뀌면 안된다!
    - 사용자별 총 구매액을 확인 후 사용금액이 1000 이상인 사람에게 사은품을 주고 싶다. 쿼리문을 짜보면
    SELECT userID '사용자', SUM(price*amount) '총 구매액' FROM buytbl GROUP BY userID ; 여기서 WHERE SUM(price*amount) > 1000을 추가했을 것이다. 근데 오류가 난다... 이럴때 사용하는게 HAVING절 이다.
    SELECT userID '사용자', SUM(price*amount) '총 구매액' FROM buytbl GROUP BY userID HAVING SUM(price*amount) > 1000 ;
    - 추가로 총 구매액이 적은 사용자부터 나타내고 싶으면 ORDER BY절 사용
    SELECT userID '사용자', SUM(price*amount) '총 구매액' FROM buytbl GROUP BY userID HAVING SUM(price*amount) > 1000 ORDER BY SUM(price*amount);

### 12. ROLL UP
    - 총합 또는 중간 합계가 필요하다면 GROUP BY절과 함께 WITH ROLL UP문을 사용하면 된다. 만약 분류별로 함계 및 총합을 구하고 싶을경우
    SELECT num, groupName, SUM(price*amount) FROM buytbl GROUP BY groupName, num WITH ROLL UP;
    groupName별 비용 소합계 행이 중간중간 추가되고, 맨 마지막행에 groupName별 비용 총합계 행이 추가된다.
