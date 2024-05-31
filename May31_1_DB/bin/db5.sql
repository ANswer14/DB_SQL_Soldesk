-- 엄청난 시행착오를 격어서 => DB를 설치
-- CMD기반의 sqlplus를 다뤄보면서 DBA들이 하는 업무 살짝 맛봤음
-- 		(계정 생성, 권한부여, tablespace)
-- 간단한 용어정리(테이블 / 행 / 열 / 스키마 / 인스턴스 / 도메인)
-- SQL의 명령문 중 정의어(DDL)를 다루면서 테이블을 만들어봤고
-- 	테이블 생성 시 필요한 자료형(주력으로 사용한 것만)
--		문자형 : varchar2 / 숫자형 : number / 날짜 : date(조만간 봄)
-- 상당히 어려웠던 제약조건 ! / not null, primary key / foreign key
-- 테이블의 구조를 수정하거나, 삭제해보면서 DDL 완료 !

-- 과자 테이블을 만들건데 
-- 과자 이름, 회사, 가격 정보를 넣고싶음
-- 테이블 하나에는 PK 하나 있었으면...! => 어디에 PK를 먹일지 생각해보면서!

-- 초코파이 : 회사 => 오리온 / 롯데 => 과자 이름 : 단일한 값이 될 수 없음
-- 회사이름 : 한 회사에서 한가지 종류의 과자만 만드는것은 아님
-- 가격 : 같은 가격의 과자 있을 수 도 있음
-- PK를 어디에 ???
-- 번호값을 만들어서 여기에 PK를 주는 것도 한 방법 !
create table snack(
	snack_number number(4) primary key
	snack_name varchar2(10 char) not null,
	snack_company varchar2(10 char) not null,
	snack_price number(7) not null,
--	primary key (snack_name, snack_company, snack_price)
);

--insert into snack values('초코파이', '롯데', 15000);
--insert into snack values('초코파이', '오리온', 15000);


drop table snack cascade constraint purge;


















