-- 데이터의 수정 : UPDATE
/* 기존에 입력되어 있는 값을 변경하기 위해서는 UPDATE문을 다음과 같은 형식으로 사용해야 한다.
   UPDATE 테이블이름 SET 열1 = 값1, 열2 = 값2 ...
   WHERE 조건 ;
   UPDATE도 사용법은 간단하지만 주의할 사항이 있다. WHERE절은 생략이 가능하지만 WHERE절을 생략하면 테이블의 전체의 행이 변경된다.
   다음 예는 kyoichi의 Lname을 없음으로 변경하는 예, 251건 반영 */
USE sqldb;
UPDATE testtbl4
	SET Lname = '없음'
    WHERE Fname = 'Kyoichi';
SELECT Fname, Lname FROM testtbl4 WHERE Lname = '없음' ;
/* 만약 실수로 WHERE을 빼먹고 UPDATE testtbl4 SET Lname = '없음'; 을 실행했다면 전체 행의 Lname이 모두 '없음'으로 변경된다.
   실무에서도 이러한 실수가 종종 일어날 수 있으므로 주의, 원상태로 복구하기 위해서는 많은 복잡한 절차가 필요하고, 다시 되돌릴 수 없는 경우도 있음.
   가끔 전체 테이블의 내용을 변경하고 싶을 때 WHERE를 생략할 수도 있는데, 예로 구매 테이블에서 현재의 단가가 모두 1.5배 인상되었다면 다음과 같이 사용할수 있음.*/
UPDATE buytbl SET price = price * 1.5 ;
SELECT price FROM buytbl;

-- 데이터의 삭제 : DELETE FROM
/* DELETE도 UPDATE와 거의 비슷한 개념이다. DELETE는 행 단위로 삭제하는데, 형식은 다음과 같다.
   DELETE FROM 테이블이름 WHERE 조건;
   만약 WHERE문이 생략되면 전체 데이터를 삭제한다.
   testtbl4에서 'Aamer' 사용자가 필요 없다면 다음과 같은 구문을 사용하면 된다.('Aamer'라는 이름의 사용자는 200명이 넘게 있음) */
DELETE FROM testtbl4 WHERE Fname = 'Aamer';
/* 만약 228건의 'Aamer'을 모두 지우는 것이 아니라 'Aamer'중에서 상위 몇 건만 삭제하려면 LIMIT구문과 함께 사용하면 된다.
   다음은 'Aamer'중에서 상위 건만 삭제
   DELETE FROM testtbl4 WHERE Fname = 'Aamer' LIMIT 5;
   대용량 테이블이 필요가 없다면 어떻게 삭제하는 것이 좋을까? 실습을 통해서 효율적인 삭제가 어떤 것인지 확인하자. 또 트랜잭션의 개념도 배워보자 */

-- 대용량 테이블을 3개 생성 employees에서
CREATE TABLE bigtbl1 (SELECT * FROM employees.employees);
CREATE TABLE bigtbl2 (SELECT * FROM employees.employees);
CREATE TABLE bigtbl3 (SELECT * FROM employees.employees);
-- 워크벤치 쿼리 창에서, 먼저 DELETE, DROP, TRUNCATE문으로 세 테이블을 모두 삭제한다. 세 구문 모두 테이블의 행을 삭제한다.(단 DROP문은 테이블 자체를 삭제)
DELETE FROM bigtbl1;
DROP TABLE bigtbl2;
TRUNCATE TABLE bigtbl3;
-- 아웃풋을 비교하면 DELETE만 오래 걸리고 나머지는 짧은 시간이 걸린 것을 확인할 수 있다.
/* DML문인 DELETE는 트랜잭션 로그를 기록하는 작업 때문에 삭제가 오래 걸린다. 수백 만 건 또는 수천만 건의 데이터를 삭제할 경우에 한참동안 삭제를 할 수도 있다. DDL문인
   DROP문은 테이블 자체를 삭제한다. 그리고 DDL은 트랜잭션을 발생시키지 않는다고 했다.역시 DDL문인 TRUNCATE문의 효과는 DELETE와 동일하지만 트랜잭션 로그를 기록하지 않아서 속도가
   무척 빠르다. 그러므로 대용량의 테이블 전체 내용을 삭제할 때는 테이블 자체가 필요 없을 경우에는 DROP으로 삭제, 테이블의 구조는 남겨놓고 싶다면 TRUNCATE로 삭제하는 것이 효율적*/

-- 조건부 데이터 입력, 변경
/* 앞에서 INSERT문이 행 데이터를 입력해 주는 것에 대해 배웠다. 그러면 기본 키가 중복된 데이터를 입력하면 어떻게 될까? 당연히 입력되지 않음.
   하지만 100건을 입력하고자 하는데 첫 번째 한건의 오류 때문에 나머지 99건도 입력되지 않는 것도 문제가 될 수 있음.
   MYSQL은 오류가 발생해도 계속 진행하는 방법을 제공 */
-- INSERT의 다양한 방식 실습
-- 우선 멤버테이블을 정의하고, 데이터를 입력. 기존 usertbl에서 아이디, 이름, 주소만 가져와서 간단히 만들어 보자
CREATE TABLE membertbl (select userID, userName, addr from usertbl limit 3); -- 3개만 가져옴
ALTER TABLE membertbl ADD CONSTRAINT pk_membertbl PRIMARY KEY (userID); -- pk를 지정
SELECT * FROM membertbl;
-- 여러 건 입력 시에 오류가 발생해도 나머지는 계속 입력되도록 하자.
-- 데이터를 추가로 3건 입력해보자 그런데 첫 번째 데이터에서 pk를 중복하는 실수를 했다.
INSERT INTO membertbl VALUES('BBK', '바비코', '미국');
INSERT INTO membertbl VALUES('SJH', '서장훈', '한국');
INSERT INTO membertbl VALUES('HJY', '현주엽', '한국');
-- 조회하면 3건 그대로이다. 왜? ID가 pk고유값인데 중복이 되어서 오류가 났기 때문
-- INSERT ignore문으로 바꿔서 다시 실행해 보자.
INSERT IGNORE INTO membertbl VALUES('BBK', '바비코', '미국');
INSERT IGNORE INTO membertbl VALUES('SJH', '서장훈', '한국');
INSERT IGNORE INTO membertbl VALUES('HJY', '현주엽', '한국');
SELECT * FROM membertbl;
-- 비록 첫 번째 행은 오류가 났지만 나머지 2건은 이상없이 삽입 완료. PK중복이라도 오류를 발생시키지 않고 무시하게 넘어간다.
-- 이번에는 입력 시에 기본키가 중복되면 데이터가 수정되도록 해보자
INSERT INTO membertbl VALUES('BBK', '바비코', '미국')
	ON DUPLICATE KEY UPDATE userName = '바비코', addr = '미국';
INSERT INTO membertbl VALUES('DJM', '동짜몽', '일본')
	ON DUPLICATE KEY UPDATE userName = '동짜몽', addr = '일본';
SELECT * FROM membertbl;
/* 첫 번째 행에서 BBK는 중복이 되었으므로 UPDATE문이 수행, 그리고 두 번째 입력한 DJM은 없으므로 일반적인 INSERT구문 결국 ON DUPLICATE UPDATE는 PK가
   중복되지 않으면 일반 INSERT가 되는 것이고, PK가 중복되면 그 뒤의 UPDATE문이 수행한다.*/
   
-- WITH절과 CTE 개요
/* WITH절은 CTE를 표현하기 위한 구문으로 MYSQL8.0 이후부터 사용할 수 있음. CTE는 기존의 뷰, 파생 테이블, 임시 테이블 등으로 사용되던 것을 대신할 수 있으며,
   더 간결한 식으로 보여지는 장점이 있다. CTESMS ANSI-SQL99 표준에서 나온것, 기존의 SQL은 ANSI-SQL92를 기준으로 함. 하지만 최근의 DBMS는 ANSI-SQL99
   와 호환되므로 DBMS에서도 같거나 비슷한 방식으로 응용된다. CTE는 비재귀적 CTE와 재귀적 CTE 2가지가 있다. 비재귀적 CTE에 대해서 학습*/
   
-- 비재귀적 CTE
/* 비재귀적 CTE는 말 그대로 재귀적이지 않은 CTE다. 단순한 형태, 복잡한 쿼리문장을 단순화 시키는 데에 적합하게 사용될 수 있다. 우선 비재귀적 CTE의 형식을 살펴보자
   WITH CTE_테이블이름(열 이름)
   AS ( < 쿼리문 > )
   SELECT 열 이름 FROM CTE_테이블이름 ;
   위쪽을 떼버리고 그냥 SELECT 열 이름 FROM CTE_테이블이름 구문만 생각해도 됨. 그런데 이 테이블은 기존에는 실제 DB에 있는 테이블을 사용했지만, CTE는 바로 위의
   WITH절에서 정의한 CTE_테이블이름을 사용하는 것만 다르다. 즉 WITH CTE_테이블이름(열 이름) AS... 형식의 테이블이 하나 더 있다고 생각하면 된다.
   쉽게 이해하기 위해서 앞에서 했던 buytbl에서 총 구매액을 구하는 것을 다시 살펴보자*/
   SELECT userid AS '사용자', SUM(price*amount) AS '총구매액' FROM buytbl GROUP BY userid;
/* 위의 결과를 총 구매액이 많은 사용자 순서로 정렬하고 싶다면 어떻게 해야 할까? 물론 앞의 쿼리에 이어서 order by문을 첨가해도 된다. 하지만 그럴 경우에는 SQL문이 더욱
   복잡해 보일 수 있으므로 이렇게 생각해 보자. 위의 쿼리의 결과가 바로 abc라는 이름의 테이블이라고 생각하면 어떨까? 정렬하는 쿼리는 다음과 같이 간단해짐
   SELECT * FROM abc ORDER BY 총구매액 DESC
   이것이 CTE 장점 중 하나, 구문 단순화이다. 지금까지 얘기한 실질적 쿼리문은 다음과 같이 작성하면 된다.*/
WITH abc(userid, total)
AS (SELECT userid, SUM(price*amount) FROM buytbl GROUP BY userid)
SELECT * FROM abc ORDER BY total DESC;
/* 제일 아래의 FROM abc 구문에서 abc는 실존하는 테이블이 아니라, 바로 위 네모로 표시된 WITH 구문으로 만든 SELECT의 결과이다. 단 여기서 AS(SELECT..에서 조회하는 열과
   WITH abc..) 개수가 일치해야 한다. 다른 예로 하나 더 연습을 해보면 usertbl에서 각 지역별로 가장 큰 키를 1명씩 뽑은 후 그사람들의 키의 평균을 내보자, 전체의 평균이라면
   AVG(height)사용하면 되지만 각 지역별로 가장 큰 키의 1명을 우선 뽑아야 하므로 얘기가 좀 복잡해짐. 이럴때 CTE를 유요하게 사용할 수 있다.
   각 지역별로 가장 큰 키를 뽑는 쿼리는 아래와 같다.*/
   SELECT addr, MAX(height) FROM usertbl GROUP BY addr;
   -- 위 쿼리를 WITH 구문으로 묶는다면
   WITH cte_usertbl(addr, maxheight)
   AS ( SELECT addr, MAX(height) FROM usertbl GROUP BY addr)
   -- 키의 평균을 구하는 쿼리를 WITH구문과 합친다. 이때 실수로 만들기 위해 키의 평균에 1.0을 곱함
   SELECT AVG(maxheight*1.0) '각 지역별 최고키의 평균' FROM cte_usertbl;
/* CTE는 뷰와 그 용도가 비슷하긴 하지만, 차이점이 존재 뷰는 계속 존재하지만, CTE는 구문이 끝나면 없어짐. 추가로 CTE에 대해서 보면 CTE는 다음 형식과 같은 중복 CTE가 허용됨.
   WITH AAA(컬럼들)
   AS (AAA의 쿼리문),
   BBB(컬럼들)
   AS (BBB의 쿼리문),
   CCC(컬럼들)
   AS (CCC의 쿼리문)
   SELECT * FROM [AAA 또는 BBB 또는 CCC]
   주의할 점은 CCC의 쿼리문에서는 AAA나 BBB를 참조할 수 있지만, AAA의 쿼리문이나 BBB의 쿼리문에서는 CCC를 참조할 수 없음. 아직 정의 되지 않은 CTE를 미리 참조 불가.*/