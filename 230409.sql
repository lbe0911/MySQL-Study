-- MySQL데이터 형식
-- 데이터 타입은 데이터 형식, 데이터형, 자료형, 데이터 타입 등 다양하게 불릴 수 있다. SELECT문을 더 잘 활용하고 테이블을 효율적으로 생성하기 위해서는 반드시 이해가 필요
-- MySQL에서 지원하는 데이터 형식 종류
-- 숫자 데이터 형식
/* 데이터 형식		|		바이트 수		|		숫자범위		|		설명		
   BIT(N)		 	    N/8			 					  1~64bit를 표현. b'0000'형식으로 표현
   TINYNT				1			  	  -128 ~ 127			정수
   SMALLINT				2				-32.768~32.767			정수
   MEDIUMINT			3			-8.388.608~8.388.607		정수
   INT					4				약 -21억 ~ +21억			정수
   BIGINT				8			  약 -900경 ~ +900경			정수
   FLOAT				4			 -3.40E+38~1.17E-38	  소수점 아래 7자리까지 표현
   DOUBLE REAL			8			-1.22E-308~1.79E+308  소수점 아래 15자리까지 표현
   DECIMAL			   5~17			-10 38제곱+1 ~ 		  전체 자릿수(m)와 소수점 이하 자릿수(d)를 가진 숫자형
   (m,[d])								+10 38제곱 -1	  예) decimal(5,2)는 전체 자릿수를 5자리로 하된 그중 소수점 이하를 2자리로 하겠다.*/
/*DEMECAL 데이터 형식은 정확한 수치를 저장하게 되고, FLOAT, DOUBLE은 근사치의 숫자를 저장. 대신 FLOAT, DOUBLE은 상당히 큰 숫자를 저장할 수 있다는 장점이 있음.
  그러므로 소수점이 들어간 실수를 저장하려면 되도록 DECIMAL을 사용하는 것이 바람직. 예로 -999999.99부터 +999999.99까지의 숫자를 저장할 경우에는 DECIMAL(9,2)로 설정
  또 MySQL은 부호 없는 정수를 지원하는데 부호 없는 정수로 지정하면 TYNYINT는 0~255, SMALLINT는 0~65535, MIDIUMINT는 0~16777215, INT는 0~약 42억, BIGINT는
  약 1800경으로 표현할 수 있다. 부호 없는 정수를 지정할 때는 UNSIGNED 예약어를 뒤에 붙여준다.
  FLOAT, DOUBLE, DECIMAL도 UNSIGNED 예약어를 사용할 수 있지만 자주 사용되지는 않는다.*/

-- 문자 데이터 형식
/*	   데이터 형식		|	바이트 수	  |					설명
   CHAR(n)			 1 ~ 255		고정길이 문자형, n을 1부터 255까지 지정. 그냥 CHAR만 쓰면 CHAR(1)과 동일
   VARCHAR(n)		 1 ~ 65535		가변길이 문자형, n을 사용하면 1부터 65535까지 지정.
   BINARY(n)		 1 ~ 255		고정길이의 이진 데이터 값
   VARBINARY(n)		 1 ~ 255		가변길이의 이진 데이터 값
TEXT형식 TINYTEXT	 1 ~ 255		255크기의 TEXT 데이터 값
	    TEXT		 1 ~ 65535		N 크기의 TEXT 데이터 값
        MEDIUMTEXT	 1 ~ 16777215	16777215크기의 TEXT 데이터 값
        LONGTEXT	 1 ~ 4294967295	최대 4GB 크기의 TEXT 데이터 값
BLOB형식 TINYBLOB	 1 ~ 255		255크기의 BLOB 데이터 값
	    BLOB		 1 ~ 65535		N 크기의 BLOB 데이터 값
        MEDIUMBLOB	 1 ~ 16777215	16777215크기의 BLOB 데이터 값
        LONGBLOB	 1 ~ 4294967295	최대 4GB 크기의 BLOB 데이터 값
ENUM(값들...)	  	 1 또는 2		최대 65535개의 열거형 데이터 값
SET(값들...)			 1,2,3,4,8		최대 64개의 서로 다른 데이터 값 */
/* CHAR 형식은 고정길이 문자형으로 자릿수가 고정되어 있다. 예를 들어, CHAR(100)에 'ABC' 3글자만 저장해도 100자리를 모두 확보한 후에 핲에 3자리를 사용하고 뒤의 97자리는 낭비하는
   결과가 나타남. VARCHAR 형식은 가변길이 문자형으로 VARCHAR(100)에 'ABC' 3글자를 저장할 경우에 3자리만 사용하게 된다. 그래서 공간을 효율적으로 운영할 수 있음.
   하지만, CHAR형식으로 설정하는 것이 INSERT/UPDATE 시에 일반적으로 더 좋은 성능을 발휘함. 
   BINARY와 VARBINARY는 바이트 단위의 이진 데이터 값을 저장하는 데 사용. TEXT형식은 대용량의 글자를 저장하기 위한 형식. 필요한 크기에 따라서 TINYTEXT, TEXT, MEDIUMTEXT, 
   LONGTEXT 등의 형식을 사용할 수 있음. BLOB는 사진 파일, 동영상 파일, 문서 파일 등의 대용량의 이진 데이터를 저장하는 데 사용될 수 있다. BLOB도 필요한 크기에 따라서
   TINYBLOB, BLOB, MEDIUMBLOB, LONGBLOB 등의 형식을 사용할 수 있음.
   ENUM은 열거형 데이터를 사용할 때 사용될 수 있는데 예로 요일(월, 화, 수, 목, 금, 토, 일)을 ENUM 형식으로 설정할 수 있다. SET은 최대 64개를 준비한 후에 입력은 그 중에서 2개씩
   세트로 데이터를 저장시키는 방식을 사용한다.*/

-- 날짜와 시간 데이터 형식
/* 	데이터 형식	|	바이트수	|				설명
	DATE			3		 날짜는 1001-01-01 ~ 9999-12-31까지 저장되며 날짜 형식만 사용 'YYYY-MM-DD'형식으로 사용
    TIME			3		 -838:59:59.000000 ~ 838:59:59.000000까지 저장되며 'HH:MM:SS'형식으로 사용
    DATETIME		8		 날짜는 1001-01-01 00:00:00 ~ 9999-12-31	23:59:59까지 저장되며, 형식은 'YYYY-MM-DD HH:MM:SS'형식으로 사용
	TIMESTAMP		4		 날짜는 1001-01-01 00:00:00 ~ 9999-12-31	23:59:59까지 저장되며, 형식은 'YYYY-MM-DD HH:MM:SS' 형식으로 사용.
							 time_zone 시스템 변수와 관련이 있으며, UTC 시간대 변환하여 저장.
	YEAR			1		 1901 ~ 2155까지 저장. 'YYYY'형식으로 사용.
    날짜와 시간형 데이터에 대해서는 간단한 예를 통해서 그 차이를 확인. */
SELECT CAST('2020-10-19 12:35:29.123' AS DATE) AS 'DATE'; -- 2020-10-10
SELECT CAST('2020-10-19 12:35:29.123' AS TIME) AS 'TIME'; -- 12:35:29
SELECT CAST('2020-10-19 12:35:29.123' AS DATETIME) AS 'DATETIME'; -- 2020-10-10 12:35:29

-- 기타 데이터 형식
/* 	데이터 형식	|	바이트수	|			설명
   GEOMETRY			N/A		 공간 데이터 형식으로 선, 점 및 다각형 같은 공간 데이터 개체를 저장하고 조작
   JSON				8		 		JSON 문서를 저장 */
   
-- LONGTEXT, LONGBLOB
/* MySQL은 LOB을 저장하기 위해서 LONGTEXT, LONGBLOB 데이터 형식을 지원. 지원되는 크기는 약 4GB 크기의 파일을 하나의 데이터로 저장 할 수 있음.
   예로 장편소설과 같은 큰 텍스트 파일이면, 그 내용을 전부 LONGTEXT 형식으로 지정된 하나의 컬럼에 넣을 수 있고, 동영상 파일과 같은 큰 바이너리 파일이면 그 내용을 전부
   LONGBLOB 형식으로 지정된 하나의 컬럼에 넣을 수 있다. 예를 들어 아래 영화사이트 데이터베이스를 참고
   
   영화 테이블										 LONGTEXT	 LONGBLOB
   영화 ID	|	영화 제목	|	감독	|	주연 배우		|	영화 대본	|	영화 동영상
   0001		 쉰들러리스트	 스필버그	 	리암니슨			####		 ####
   0002		 쇼생크 탈출	 프랭크다라본트	 팀 로빈스		####		 ####
   0003		 라스트모히칸	 마이클 만  다니엘 데이 루이스		####		 ####
영화 대본 열에는 대본 전체가 들어가고, 영화 동영상 열에는 실제 영화 파일 전체가 들어갈 수 있다. 실무에서는 이러한 방식도 종종 사용되니 잘 기억해 놓으면 도움이 된다. 대량의 데이터를
입력하는 실습을 해보자 */ 

-- 변수의 사용
/* SQL도 다른 일반적인 프로그래밍 언어처럼 변수를 선언하고 사용할 수 있다. 변수의 선언과 값의 대입은 다음의 형식을 참고
   SET @변수이름 = 변수의 값; -- 변수의 선언 및 값 대입
   SELECT @변수이름 ;       -- 변수의 값 출력
   변수는 워크벤치를 재시작할 때까지는 계속 유지되나 워크벤티를 닫았다가 재시작 하면 소멸됨.
   간단히 변수의 사용 실습 해보기*/
USE sqldb;
SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '가수 이름 ==>' ;

SELECT @myVar1 ;
SELECT @myVar2 + @myVar3 ;

SELECT @myVar4, userName FROM usertbl WHERE height > 180 ;
-- 변수의 값은 일반적인 SELECT, FROM문과도 같이 사용할 수 있음.
-- LIMIT에는 원칙적으로 변수를 사용할 수 없으나 PREPARE와 EXECUTE문을 활용해서 변수의 활용도 가능하다.
SET @myVar1 = 3;
PREPARE myQuery
	FROM 'select userName, height FROM usertbl ORDER BY height LIMIT ?';
EXECUTE myQuery USING @myVar1 ;
/* LIMIT은 LIMIT3과 같이 직접 숫자를 넣어야 하며 LIMIT @변수 형식으로 사용하면 오류가 발생하기 때문에 다른 방식을 사용해야함. PREPARE 쿼리이름 FROM '쿼리문'은 쿼리이을메
   '쿼리문'을 준비만 해놓고 실행하지는 않음. 그리고 EXECUTE 쿼리 이름을 만나는 순간 실행됨. EXECUTE는 USING @변수를 이용해 '쿼리문'에서 ?으로 처리해 놓은 부분데 대임.
   결국 LIMIT @변수 형식으로 사용된 것과 동일한 효과를 갖게 된다.*/

-- 데이터 형식과 형 변환
/* 데이터 형식 변환 함수
   가장 일반적응로 사용되는 데이터 형식 변환과 관련해서는 CAST(), CONVERT() 함수를 사용한다. CAST(), CONVERT()는 형식만 다를 뿐 거의 비슷한 기능을 함.
   형식 : 
   CAST( expression AS 데이터형식 [ (길이) ] )
   CONVERT( expression , 데이터형식 [ (길이) ] )
   데이터 형식 중에서 가능한 것은 BINARY, CHAR, DATE, DATETIME, DECIMAL, JSON, SIGNED INTEGER, TIME, UNSIGNED INTEGER 등 이다.
   사용 예 sqldb의 구매 테이블에서 평균 구매 개수를 구하는 쿼리문 */
   SELECT AVG(amount) AS '평균 구매 개수' FROM buytbl;
   -- 그런데 개수이므로 정수로 보기 위해서 다음과 같이 CAST 함수나 CONVERT 함수를 사용 할 수 있다.
   SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균 구매 개수' FROM buytbl;
   SELECT CONVERT(AVG(amount), SIGNED INTEGER) AS '평균 구매 개수' FROM buytbl;
   
-- 다양한 구분자를 날짜 형식으로 변경 할 수 있다.
SELECT CAST('2020$12$12' AS DATE);
SELECT CAST('2020/12/12' AS DATE);
SELECT CAST('2020%12%12' AS DATE);
SELECT CAST('2020@12@12' AS DATE);
-- 쿼리의 결과를 보기 좋도록 처리할 떄도 사용한다. 단가와 수량을 곱한 실제 입금액을 표시하는 쿼리는 다음과 같이 사용할 수 있다.
SELECT num, CONCAT(CAST(price AS CHAR(10)), 'X', CAST(amount AS CHAR(4)), '=') AS '단가x수량', price*amount AS '구매액' FROM buytbl;

-- 암시적인 형 변환
/* 형 변환 방식에는 명시적인 변환과 암시적인 변환, 두 가지가 있음. 명시적인 변환은 위에서 한 CAST 또는 CONVERT 함수를 이용해 데이터 형식을 변환하는것을 말함. 암시적인
   변환은 CAST나 CONVERT 함수를 사용하지 않고 형이 변환되는 것을 말함. */
SELECT '100'+'200' ; -- 문자와 문자를 더함(정수로 변환되서 연산이 됨)
SELECT CONCAT('100','200') ; -- 문자와 문자를 연결(문자로 처리)
SELECT CONCAT(100, '200') ; -- 정수와 문자를 연결(정수가 문자로 변환되서 처리)
SELECT 1 > '2mega' ; -- 정수인 2로 변환되서 비교
SELECT 3 > '2MEGA' ; -- 정수인 2로 변환되서 비교
SELECT 0 = 'mega2' ; -- 문자는 0으로 변환됨.
/* 첫 번째 결과인 문자열 + 문자열은 더하기 연산자 떄문에 문자열이 숫자로 변경되어서 계산되었다.
   두 번째는 문자열을 연결해주는 CONCAT	 함수이기에 문자열이 그대로 문자열 처리가 되었다.
   세 번째도 CONCAT 함수 안의 숫자는 문자열로 변환되어 처리되었다.
   네 번째와 비교 연산자인데 앞에 '2'가 들어간 문자열이 숫자로 변경되어서 결국 '1>2'의 비교가 된다. 결과는 거짓 0
   다섯 번째도 마찬가지 마지막 mega2 문자열은 숮자로 변경되어도 그냥 0으로 되기 때문에 결국 0 = 0이 되어 true 1 */
   
-- MySQL 내장함수
/* MySQL은 많은 내장함수를 포함. 내장 함수는 크게 제어 흐름 함수, 문자열 함수, 수학 함수, 날짜/시간 함수, 전체 텍스트 검색 함수, 형 변환 함수, XML함수, 비트 함수, 보안/압축 함수
   정보 함수, 공간 분석 함수, 기타 함수 등으로 나눌 수 있다. 전체 함수의 개수는 수백 개가 넘으며, 이중 일부는 이미 책의 중간중간 사용. 지금까지 다루지 않았던 내장함수 중에서
   가장 자주 쓰이는 함수를 배워보자. 각각 소개된 함수의 예를 직접 쿼리 창에서 실험을 해 봐라.*/

-- 제어 함수
-- 제어 흐름 함수는 프로그램의 흐름을 제어한다.
-- IF(수식, 참, 거짓)
-- 수식이 참 또는 거짓인지 결과에 따라서 2중 분기한다.
SELECT IF (100>200, '참이다', '거짓이다'); -- 거짓이 출력
-- IFNULL(수식1, 수식2)
-- 수식1이 NULL이 아니면 수식1이 반환되고, 수식1이 NULL이면 수식2가 반환된다.
SELECT IFNULL (NULL, '널이군요'), IFNULL(100, '널이군요');
-- CASE ~ WHEN ~ ELSE ~ END CASE는 내장 함수는 아니며 연산자로 분류된다. 다중 분기에 사용될 수 있으므로 내장 함수와 함께 알아두자.
SELECT CASE 10 
		WHEN 1 THEN '일'
        WHEN 5 THEN '오'
        WHEN 10 THEN '십'
        ELSE '모름'
	END AS 'CASE연습';
-- CASE 뒤의 값이 10이므로 세 번째 WHEN이 수행되어 '십'이 반환 된다. 만약 해당하는 사항이 없으면 ELSE부분이 반환된다. 마지막 END AS 뒤에는 출력될 열의 별칭을 써주면 된다.

-- 문자열 함수
-- 문자열 함수는 문자열을 조작한다. 활용도가 높으므로 잘 알아두도록 한다.

-- ASC11(아스키 코드), CHAR(숫자)
-- 문자의 아스키 코드값을 돌려주거나 숫자의 아스키 코드값에 해당하는 문자를 돌려준다.
SELECT ascii('A'), char(65);
-- BIT_LENGTH(문자열), CHAR_LENGTH(문자열), LENGTH(문자열)
-- 할당된 bit크기 또는 문자 크기를 반환한다. CHAR_LENGTH는 문자의 개수를 반환하며, LENGTH는 할당된 Byte 수를 반환한다.
SELECT bit_length('abc'), char_length('abc'), length('abc');
SELECT bit_length('가나다'), char_length('가나다'), length('가나다');
-- MySQL은 기본으로 UTF-8 코드를 사용하기 때문에 영문은 3Byte를 한글은 3x3=9Byte를 할당한다.

-- CONCAT(문자열1, 문자열2,...), CONCAT_WS(구분자, 문자열1, 문자열2...)
-- 문자열을 이어준다. CONCAT_WS는 구분자와 함께 문자열을 이어준다.
SELECT concat_ws('/', '2025','01','01');
-- 구분자 / 를 추가해서 2025/01/01이 반환된다.

/* ELT(위치, 문자열1, 문자열2, ...), FIELD(찾을 문자열, 문자열1, 문자열2, ...), FIND_IN_SET(찾을 문자열, 문자열 리스트), INSTR(기준 문자열, 부분 문자열),
   LOCATE(부분 문자열, 기준 문자열)
   ELT는 위치 번째에 해당하는 문자열을 반환한다. FIELD는 매치되는 문자열이 없으면 0을 반환한다. FIND_IN_SET은 찾을 문자열을 문자열 리스트에서 찾아 위치를 반환한다.
   문자열 리스트는 콤마 , 로 구분되어 있어야 하며 공백이 없어야 한다. INSTR는 기준 문자열에서 부분 문자열을 찾아서 그 시작 위치를 반환한다.
   LOCATE는 INSTR와 동일하지만 파라미터의 순서가 반대로 되어있다. */
SELECT ELT(2, '하나', '둘', '셋'), FIELD('둘', '하나', '둘', '셋'), FIND_IN_SET('둘', '하나,둘,셋'), LOCATE('둘','하나둘셋'), INSTR('하나둘셋', '둘') ;

-- FORMAT(숫자, 소수점 자릿수)
-- 숫자를 소수점 아래 자릿수까지 표현한다. 또한 1000 단위마다 콤마 , 를 표시해 준다.
SELECT format(123456.123456, 4); -- 123,456.1235

-- BIN(숫자), HEX(숫자), OCT(숫자)
-- 2진수, 16진수, 8진수의 값을 반환한다.
SELECT BIN(31), HEX(31), OCT(31);

-- INSERT(기준 문자열, 위치, 길이, 삽입할 문자열)
-- 기준 문자열의 위치부터 길이만큼을 지우고 삽입할 문자열을 끼워 넣는다.
SELECT insert('abcdefghi', 3, 4, '@@@@'), insert('abcdefghi', 3, 2, '@@@@');

-- LEFT(문자열, 길이), RIGHT(문자열, 길이)
-- 왼쪽 또는 오른쪽에서 문자열의 길이만큼 반환한다.
SELECT left('abcdefghi', 3), right('abcdefghi', 3); 

-- UPPER(문자열), LOWER(문자열) 
-- 소문자를 대문자로, 대문자를 소문자로 변경한다.
SELECT lower('abcdEFGH'), upper('ABCdefgh');
-- *LOWER는 LCASE와 UPPER는 UCASE와 동일한 함수.

-- LPAD(문자열, 길이, 채울 문자열), RPAD(문자열, 길이, 채울 문자열)
-- 문자열을 길이만큼 늘린 후에, 빈 곳을 채울 문자열로 채운다.
SELECT LPAD('이것이', 5, '##'), RPAD('이것이', 5, '##');

-- LTRIM(문자열), RTRIM(문자열)
-- 문자열의 왼쪽/ 오른쪽 공백을 제거한다. 중간의 공백은 제거되지 않는다.
SELECT LTRIM('    이것이'), RTRIM('이것이    ');

-- TRIM(문자열), TRIM(뱡향 자를_문자열 FROM 문자열)
-- TRIM(문자열)은 문자열의 앞뒤 공백을 모두 없앤다. TRIM(방향 자를_문자열 FROM 문자열)에서 방향은 LEADING(앞), BOTH(양쪽), TRAILING(뒤)가 나올 수 있다.
SELECT TRIM('  이것이  '), TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋ재밌어요.ㅋㅋㅋ');

-- REPEAT(문자열, 횟수)
-- 문자열을 횟수만큼 반복한다. 
SELECT REPEAT('이것이', 3);
-- 
-- REPLACE(문자열, 원래 문자열, 바꿀 문자열)
-- 문자열에서 원래 문자열을 찾아서 바꿀 문자열로 바꿔준다.
SELECT REPLACE('이것이 MySQL이다', '이것이', 'This is');
--
-- REVERSE(문자열)
-- 문자열의 순서를 거꾸로 만든다.
SELECT REVERSE ('MySQL');

-- SPACE(길이)
-- 길이만큼의 공백을 반환한다.
SELECT CONCAT('이것이', SPACE(10), 'MySQL 이다');

-- SUBSTRING(문자열, 시작위치, 길이), SUBSTRING(문자열 FROM 시작위치 FOR 길이)
-- 시작 위치부터 길이만큼 문자를 반환한다. 길이가 생략되면 문자열의 끝까지 반환한다.
SELECT substring('대한민국만세', 3, 2);
SELECT substring('대한민국만세' FROM 3 FOR 2);
-- *SUBSTRING, SUBSTR, MID는 모두 동일한 함수다.

-- SUBSTRING_INDEX(문자열, 구분자, 횟수)
-- 문자열에서 구분자가 왼쪽부터 횟수 번째 나오면 그 이후의 오른쪽은 버린다. 횟수가 음수면 오른쪽부터 세고 왼쪽을 버린다.
SELECT substring_index('cafe.naver.com', '.', 2), substring_index('cafe.naver.com', '.', -2);
