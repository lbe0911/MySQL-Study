-- 수학 함수
-- 다양한 수학 함수 제공
-- ABS(숫자)
SELECT abs(-100);
-- 절대값인 100을 반환한다.

-- ACOS(숫자), ASIN(숫자), ATAN(숫자), ATAN2(숫자), SIN(숫자), COS(숫자) TAN(숫자)
-- 삼각 함수와 관련된 함수를 제공
-- CEILING(숫자), FLOOR(숫자), ROUND(숫자)
-- 올림, 내림, 반올림을 계산한다.
SELECT ceiling(4.7), FLOOR(4.7), ROUND(4.7);
-- * CEILING = CEIL과 동일한 함수

-- COMNV(숫자, 원래 진수, 변환할 진수)
-- 숫자를 원래 진수에서 변환할 진수로 계산
SELECT CONV('AA',18,2), CONV(100,10,8);
-- 16진수 AA를 2진수로 변환한 10101010과 100을 8진수로 변환한 144가 반환

-- DEGREES(숫자), RADIANS(숫자), PI()
-- 라디안 값을 각도값으로, 각도값을 라디안 값으로 변환한다. PI는 파이값인 3.141592를 반환한다,
SELECT DEGREES(PI()), RADIANS(180);
-- 파이의 각도값인 180과 180의 라디언 값이 출력됨,

-- EXP(X), LN(숫자), LOG(숫자), LOG(밀수,숫자), LOG2(숫자), LOG10(숫자)
-- 지수, 로그와 관련된 함수를 제공한다.

-- MOD(숫자1, 숫자2) 또는 숫자1 % 숫자2 또는 숫자1 MOD 숫자2
-- 숫자1을 숫자2로 나눈 나머지 값을 구한다.
SELECT MOD(157,10), 157 % 10, 157 MOD 10;
-- 모두 157을 10으로 나눈 나머지 값 7을 반환한다.

-- POW(숫자1, 숫자2), SQRT(숫자)
-- 거듭제곱값 및 제곱근을 구한다,
SELECT POW(2,3), SQRT(9);
-- *POW와 POWER은 동일한 함수다.

-- RAND()
-- RAND()는 0 이상 1 미만의 실수를 구한다. 만약 m <= 임의의 정수 < n을 구하고 싶으면  FLOOR (m+(RAND() * (n-m)을 사용하면 된다.
SELECT RAND(), FLOOR(1+ (RAND() * (7-1)) );
-- 0~1미만의 실수와 주사위 숫자를 구한다.
-- SIGN(숫자)
-- 숫자가 양수, 0, 음수인지 구한다. 결과는 1, 0 , -1 셋 중에 하나를 반환한다.
SELECT SIGN(100), SIN(0), SIGN(-100.123);

-- TRUNCATE(숫자, 정수)
-- 소수점을 기준으로 정수 위치까지 구하고 나머지는 버린다.
SELECT truncate(12345.12345, 2), truncate(12345.12345, -2);

-- 날짜 및 시간함수
-- 날짜 및 시간을 조작하는 다양한 함수를 사용할 수 있다.
-- ADDDATE(날짜, 차이), SUBDATE(날짜, 차이)
-- 날짜를 기준으로 차이를 더하거나 뺀 날짜를 구한다.
SELECT ADDDATE('2025-01-01', INTERVAL 31 DAY), ADDDATE('2025-01-01', INTERVAL 1 MONTH);
SELECT SUBDATE('2025-01-01', INTERVAL 31 DAY), SUBDATE('2025-01-01', INTERVAL 1 MONTH);
-- 31일 후 또는 한달 후인 2025-02-01과 31일 전 또는 한달 전인 '2024-01-01을 반환
-- ADDDATE = DATE_ADD / SUPDATE = DATE_SUB 동일한 함수

-- ADDTIME(), SUBTIME()
-- 날짜/시간을 기준으로 시간을 더하거나 뺀 결과를 구한다.
SELECT ADDTIME('2025-01-01 23:59:59', '1:1:1'), ADDTIME('15:00:00', '2:10:10');
SELECT SUBTIME('2025-01-01 23:59:59', '1:1:1'), SUBTIME('15:00:00', '2:10:10');
-- 1시간 1분 1초 후, 2시간 10분 10초 후 결과 반환, 1시간 1분 1초 전, 2시간 10분 10초 전 결과 반환

-- CURDATE(), CURTIME(), NOW(), SYSDATE()
-- CURDATE()는 현재 연-월-일을, CURTIME은 현재 시:분:초를 구한다. NOW()와 SYSDATE()는 현재 연-월-일 시:분:초를 구한다.
-- CURDATE(), CURRENT_DATE(), CURRENT_DATE, CURTIME(), CURRENT_TIME(), CURRENT_TIME, NOW(), LOCALTIME, LOCALTIME(), LOCALTIMESTAMP, LOCALTIMESTAMP() 모두 동잃

-- YEAR(날짜), MONTH(날짜), DAY(날짜), HOUR(시간), MINTE(시간), SECOND(시간), MICROSECOND(시간)
-- 날짜 또는 시간에서 연, 월, 일, 시, 분, 초, 밀리초를 구한다.
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());
SELECT HOUR(CURTIME()), MINUTE(CURRENT_TIME()), SECOND(CURTIME()), MICROSECOND(CURRENT_TIME);
-- 현재 연, 월, 일 / 시, 분, 초, 밀리초를 구한다.
-- * DAYOFMoNTH와 DAY는 동일하다.

-- DATE(), TIME()
-- DATETIME 형식에서 연-월-일 및 시:분:초만 추출한다.
SELECT DATE(NOW()), TIME(NOW());
-- 현재 연-월-일, 시:분:초 를 구한다.

-- DATEDIFF(날짜1, 날짜2), TIMEDIFF(날짜1 또는 시간1, 날짜1 또는 시간2)
-- DATEDIFF()는 날짜1-날짜2의 일수를 결과로 구한다. 날짜 2에서 날짜1까지 몇 일이 남았는지 구한다. TIMEDIFF()는 시간1-시간2의 결과를 구한다.
SELECT DATEDIFF('2025-01-01', NOW()), TIMEDIFF('23:59:59', '12:11:10');
-- 2025년 1월 1일에서 오늘의 날짜를 뺀 결과, 11:48:49초 반환

/* DAYOFWEEK(날짜), MONTHNAME(), DAYOFYEAR(날짜)
   요일(1:일, 2:월,~7:토) 및 1년 중 몇 번째 날짜인지를 구한다.*/
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE());
-- 현재 요일과 월 이름 그리고 일년 중 몇 일이 지났는지를 반환

/* LAST_DAY(날짜)
   주어진 날짜의 마지막 날짜를 구한다. 주로 그 달이 몇 일까지 있는지 확인할 때 사용한다.*/
   SELECT LAST_DAY('2025-02-01');
   -- 2025-02-28
   
/* MAKEDATE(연도, 정수)
   연도에서 정수만큼 지난 날짜를 구한다. */
   SELECT MAKEDATE(2024, 32);
   -- 2025-02-01
   
/* MAKETIME(시, 분, 초)
   시, 분, 초를 이용해서 시:분:초의 타임 형식을 만든다. */
   SELECT MAKETIME(12, 10, 11);
   -- 12:10:11
   
/* PERIOD_ADD(연월, 개월수), PERIOD_DIFF(연월1, 연월2)
   PERIOD_ADD()는 연월에서 개월만큼의 개월이 지난 연월을 구한다. 연월은 YYYY 또는 YYYYMM형식을 사용한다. PERIOD_DIFF()는 연월1-연월2의 개월수를 구한다.*/
   SELECT PERIOD_ADD(202501, 11), PERIOD_DIFF(202501, 202312);
   -- 202512, 13개월 반환
   
/* QUARTER(날짜)
   날짜가 4분기 중에서 몇 분기인지를 구한다. */
   SELECT QUARTER('2025-07-07');
   -- 3분기를 반환

/* TIME_TO_SEC(시간)
   시간을 초 단위로 구한다.*/
   SELECT TIME_TO_SEC('12:10:11');   
   -- 43870초가 반환
   
/* 시스템 정보 함수
   시스템의 정보를 출력하는 함수를 제공한다.
   
   USER(), DATABASE()
   현재 사용자 및 현재 선택된 데이터베이스를 구한다.*/
   SELECT CURRENT_USER, DATABASE();
   -- 현재 사용자와 현대 선택된 데이터베이스를 반환한다.
   -- * USER(), CURRENT_USER(), SESSION_USER()는 모두 동일하다. DATABASE()와 SCHEMA()도 동일한 함수.
   
/* FOUND_ROWS()
   바로 앞의 SELECT문에서 조회된 행의 개수를 구한다.*/
   USE sqldb;
   SELECT * FROM usertbl;
   select FOUND_ROWS();
   -- 고객 테이블의 10개 행을 조회했으므로 10을 반환한다.
   
/* ROW_COUNT()
   바로앞의 INSERT, UPDATE, DELETE문에서 입력, 수정, 삭제된 행의 개수를 구한다. CREATE, DROP문은 0을 반환하고, SELECT문은 -1을 반환*/
   UPDATE buytbl SET price=price*2;
   SELECT * FROM buytbl;
   SELECT ROW_COUNT();
   
/* VERSION()
   현재 MySQL의 버전을 구한다.
   
   SLEEP(초)
   쿼리의 실행을 잠깐 멈춘다. */
   SELECT SLEEP(5);
   SELECT '5초후에 이게 보여요';
   
/* 피벗의 구현
   피벗은 한 열에 포함된 여러 값을 출력하고, 이를 여러 열로 변환하여 테이블 반환 식을 회전하고 필요하면 집계까지 수행하는 것을 말한다.
   예를 들어 왼쪽 테이블은 판매자 이름, 판매 계절, 판매 수량으로 구성된 테이블이 있고, 이를 각 판매자가 계절별로 몇 개 구매했는지 표로 나타내고 싶을 때
   SUM()과 IF() 함수를 활용해서 피벗 테이블을 만들 수 있다.
   피벗 테이블 실습 하기 
   
   셈플 테이블 만들기 */
   USE sqldb;
   CREATE TABLE pivottbl ( uName CHAR(3), season ChaR(2), amount INT);
   
   -- 데이터 입력해서 추가 시키기
   INSERT INTO pivottbl VALUES('김범수', '겨울', 10),('윤종신', '여름', 15),('김범수', '가을', 25),('김범수', '봄', 3),('김범수', '봄', 37),('윤종신', '겨울', 40),
								('김범수', '여름', 14),('김범수', '겨울', 22),('윤종신', '여름', 64);
   SELECT * FROM pivottbl;
   
   -- SUM(), IF()함수 그리고 GROUP BY를 활용.
   SELECT uName AS '판매자 이름', SUM(IF(season='봄', amount, 0)) AS '봄',
				 SUM(IF(season='여름', amount, 0)) AS '여름',
                 SUM(IF(season='가을', amount, 0)) AS '가을',
                 SUM(IF(season='겨울', amount, 0)) AS '겨울',
                 SUM(amount) AS '합계' FROM pivottbl /*GROUP BY uName*/ ;
	
    SELECT season, SUM(IF(uName = '김범수', amount, 0)) AS '김범수',
				   SUM(IF(uName='윤종신', amount, 0)) AS '윤종신', 
                   SUM(amount) AS '합계' FROM pivottbl
        GROUP BY season ORDER BY season;
        
-- JSON데이터
/* JSON은 현대의 웹과 모바일 응용 프로그램 등과 데이터를 교환하기 위한 개방형 표준 포맷을 말한다. 속성과 값으로 쌍을 이루며 구성되어 있다.ALTER
   JSON은 비록 Javascript언어에서 파생되었지만 특정한 프로그래밍 언어에 종속되어 있지 않은 독립적인 데이터 포맷이라고 생각하면 된다. 즉, 그 포맷이 단순하고 공개되어
   있기에 거의 대부분의 프로그래밍 언어에서 쉽게 읽거나 쓸 수 있도록 코딩할 수 있다.
   JSON의 가장 단순한 형태의 예를 들면 다음과 같다. 한 명의 사용자를 JSON 형태로 표현한 것이다. 속성과 값으로 쌍을 이루는것을 확인할 수 있다.
   { "아이디" : "BBK" ,
	 "이름" : "바비킴" ,
     "생년" : 1973 ,
     "지역" : "서울" ,
     "국번" : "010" ,
     "전화번호" : "00000000" , 
     "키" : 178 ,
     "가입일" : "2013.5.5" }
	MySQL은 JSON 관련된 다양한 내장 함수를 제공해서 다양한 조작이 가능, 우선 테이블의 데이터를 JSON 데이터로 표현하면 다음과 같음.
    MySQL 테이블          |JSON 데이터
    name  |   height     name   |   height
    임재범  |  182        {"name" : "임재범", "height" : 182}
    이승기  |  182        {"name" : "임재범", "height" : 182}
    성시경  |  186        {"name" : "임재범", "height" : 182}
    
  우선 왼쪽의 테이블은 usertbl에서 키가 180이상인 사람의 이름과 키를 나타낸다. 이것을 JSON으로 변환하려면 JSON_OBJECT나 JSON_ARRAY 함수를 이용하면 된다.*/
  use sqldb;
  SELECT JSON_OBJECT('userName',userName,'height',height) AS 'JSON값'
        FROM usertbl WHERE height >= 180;
/* 결과 값은 JSON형태로 되어있다. 이렇게 구성된 JSON을 MySQL에서 제공하는 다양한 내장함수를 사용해서 운영할 수 있다. JSON관련 함수의 사용법을 확인해보면 */
SET @json = '{ "usertbl" :
              [{"name" : "임재범", "height" : 182},
               {"name" : "이승기", "height" : 182},
               {"name" : "성시경", "height" : 186}] }';
SELECT JSON_VALID(@json) AS JSON_VALID;
SELECT JSON_SEARCH(@json, 'one', '성시경') AS JSON_SEARCH;
SELECT JSON_EXTRACT(@json, '$.usertbl[2].name') AS JSON_EXTRACT;
SELECT JSON_INSERT(@json, '$.usertbl[1].mDate', '2009-09-09') AS JSON_INSERT;
SELECT JSON_REPLACE(@json, '$.usertbl[0].name', '홍길동') AS JSON_REPLACE;
SELECT JSON_REMOVE(@json, '$.usertbl[0]') AS JSON_REMOVE;

/* @json 변수에 JSON데이터를 우선 대입하면서 테이블의 이름은 usertbl로 지정했다. VALID 함수는 문자열이 JSON 형식을 만족하면 1, 아니면 0을 반환
   SEARCH 함수는 세 번째 파라미터에 주어진 문자열의 위치를 반환한다. 두번째는 ONE과 ALL이 올수 있고, ONE은 처음으로 매치되는 하나만 반환, ALL은 매치되는 모든것을 반환
   결과를 보면 성시경은 usertbl의 두 번째의 name에 해당하는 부분에 위치하는 것을 확인할 수 있다.
   EXTRACT는 SEARCH와 반대로 지정된 위치의 값을 추출한다. INSERT는 새로운 값을 추가한다. usertbl 첫 번째(0)에 mDate를 추가했다.
   REPLACE는 값을 변경한다. 첫 번째(0)의 name부분을 '홍길동'으로 변경했다.
   REMOVE는 지정된 항목을 삭제한다. 첫 번째(0)의 항목을 통째로 삭제했다.*/
   
-- JOIN
/* 두 개 이상의 테이블을 서로 묶어서 하나의 결과 집합으로 만들어 내는 것.
 - INNER JOIN : 조인 중에서 가장 많이 사용되는 조인. 대개 업무에서 조인은 INNER JOIN을 사용한다. 일반적으로 JOIN이라고 얘기하는 것이 이 INNER JOIN을 지칭
 - 형식 : SELECT <열 목록>
         FROM <첫 번째 테이블>
             INNER JOIN <두 번째 테이블>
             ON <조인될 조건>
		[WHERE 검색조건]
   위의 형식에서 INNER JOIN을 그냥 JOIN이라고 써도 인식한다.*/
use sqldb;
SELECT * FROM buytbl INNER JOIN usertbl ON buytbl.userID = usertbl.userID WHERE buytbl.userID = 'JYP';
-- 두 개의 테이블을 결합하는 경우 동일한 열 이름이 있다면 꼭 '테이블명.열 이름' 형식응로 표기해줘야 한다.
-- 만약 WHERE buytbl.userID = 'JYP'를 생략하면 buytbl의 모든 행에 대해서 위와 동일한 방식으로 반복하게 된다. 아래는 WHERE를 뺀 결과
SELECT * FROM buytbl INNER JOIN usertbl ON buytbl.userID = usertbl.userID ORDER BY num;
-- 필요한 열만 추출
SELECT userID, userName, prodName, addr, mobile2 FROM buytbl INNER JOIN usertbl ON buytbl.userID = usertbl.userID ORDER BY num;
-- 오류가 난다.. 내용은 userID가 불확실하다. 왜? 테이블 두 개에 존재해서. 이럴때는 어떤테이블에 userID를 추출할지 알려줘야 한다.
SELECT buytbl.userID, userName, prodName, addr, mobile2 FROM buytbl INNER JOIN usertbl ON buytbl.userID = usertbl.userID ORDER BY num;
-- 위 구문을 INNER JOIN을 생략하고 WHERE로 조인을 표현할수 있다.
SELECT buytbl.userID, userName, prodName, addr, mobile1+mobile2 FROM buytbl, usertbl WHERE buytbl.userID = usertbl.userID ORDER BY num;
-- SELECT 다음의 열 이름에 테이블이름. 열 이름을 모두 붙여주자.
SELECT buytbl.userID, usertbl.userName, buytbl.prodName, usertbl.addr, concat(usertbl.mobile1, usertbl.mobile2) AS '연락처' FROM buytbl
INNER JOIN usertbl ON buytbl.userID = usertbl.userID ORDER BY buytbl.num;
-- 각 열이 어느 테이블에 속한 것인지 명확하게 보인다. 근데 너무 길다. 이때 from절에 나오는 테이블의 이름뒤에 AS를 써서 간결하게 만들 수 있다.
SELECT B.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM buytbl AS B INNER JOIN usertbl U ON B.userID = U.userID ORDER BY B.num;
-- 이번에는 회원 테이블에 JYP가 구매한 물건을 알아보자
SELECT U.userID, U.userName, B.prodName, U.addr FROM usertbl U INNER JOIN buytbl B ON U.userID = B.userID WHERE U.userID = 'JYP';
-- 전체 회원들이 구매한 목록을 모두 출력해보자.
SELECT U.userID, U.userName, B.prodName, U.addr FROM usertbl U INNER JOIN buytbl B ON U.userID = B.userID ORDER BY U.userID;
/* 여기서 한가지 봐야할건 전체 회원들을 조회해야 하는데 구매를 한 모든 회원만 출력이 됐다는거다. 구매도 안한 회원들이 출력되어야 하는데 이때 쓰는데 OUTER JOIN이다.
INNER JOIN은 양쪽 테이블에 모두 있는 내용만 출력, 교집합이고, OUTER JOIN은 INNER JOIN처럼 양쪽에 내용이 있으면 출력, 한쪽에만 있어도 JOIN되어 출력된다. */
/* 앞에 INNER JOIN은 한쪽에는 없는 목록만 나오기 때문에 유용한 경우도 있다. ex) 쇼핑몰에서 한번이라도 구매한 기록이 있는 우수한 회원들에게 감사의 안내장을 발송할 경우
DISTINCT문을 활용해서 회원의 주소록을 뽑을수 있다.*/
SELECT DISTINCT U.userID, U.userName, U.addr FROM usertbl U INNER JOIN buytbl B ON U.userID = B.userID ORDER BY U.userID ;
-- 위의 결과를 EXISTS문을 사용해서도 동일한 결과가 나온다.
SELECT U.userID, U.userName, U.addr FROM usertbl U WHERE EXISTS( SELECT * FROM buytbl B WHERE U.userID = B.userId);
-- 이번에는 세 개의 테이블의 조인을 살펴보자. 먼저 세 개의 테이블을 생성하자.
CREATE TABLE stdtbl (stdName VARCHAR(10) NOT NULL PRIMARY KEY,
					 addr CHAR(3) NOT NULL);
CREATE TABLE clubtbl (clubName VARCHAR(10) NOT NULL PRIMARY KEY,
					 roomNo CHAR(4) NOT NULL);
CREATE TABLE stdclubtbl (num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
						 stdName VARCHAR(10) NOT NULL,
                         clubName VARCHAR(10) NOT NULL,
                         FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
                         FOREIGN KEY(clubName) REFERENCES clubtbl(clubName));
INSERT INTO stdtbl VALUES('김범수', '경남'), ('성시경', '서울'), ('조용필', '경기'), ('은지원', '경북'), ('바비킴', '서울');
INSERT INTO clubtbl VALUES('수영', '101호'), ('바둑', '102호'), ('축구', '103호'), ('봉사', '104호');
INSERT INTO stdclubtbl VALUES(null, '김범수', '바둑'), (null, '김범수', '축구'), 
(null, '조용필', '축구'), (null, '은지원', '축구'), (null, '은지원', '봉사'), (null, '바비킴', '봉사');
-- 학생 테이블, 동아리 테이블, 학생동아리 테이블을 이용해서 학생을 기준으로 학생 이름/지역/가입한 동아리/동아리방을 출력하자.
SELECT S.stdName, S.addr, C.clubName, C.roomNo FROM stdtbl S INNER JOIN stdclubtbl SC ON S.stdName = SC.stdName
															 INNER JOIN clubtbl C ON C.clubName = SC.clubName ORDER BY S.stdName;
/* 세 개의 테이블을 조인할경우 INNER JOIN절이 2번 들어간다. 다만 테이블 번호 1,2,3 으로 했을때 2번 테이블이 1번과 3번의 PK를 FK로 가지고 있으면 1번 INNER JOIN 절
에서 1번 2번 조인 / 2번 INNER JOIN에서 2번 3번 조인을 하면 된다. */


			