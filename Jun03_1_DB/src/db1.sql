create table jun03_snack(
	snack_number number(4) primary key,
	snack_name varchar2(10 char) not null,
	snack_company varchar2(10 char) not null,
	snack_price number(7) not null
);
-- DML !은 데이터 조작어 (Data Manipulation Language)라고 하고, 
-- 테이블에 데이터를 검색, 삽입, 수정, 삭제 하는데 사용되는 문장
-- select, insert, update, delete 등이 있고, 
-- 줄여서 CRUD (create read update delete)라고 함
-- 여기서 C는 데이터를 만든다는 의미의 C(insert)
--		cf) create table - X (DBA의 작업)
-- 형태는
insert into 테이블명(컬럼명, 컬럼명, ...) values(값, 값, ...); 

insert into jun03_snack(snack_number, snack_name, snack_company, snack_price) values(1, '초코파이', '오리온', 5000);

-- 컬럼의 순서 바꾸기 - 됨!
insert into jun03_snack(snack_name, snack_number, snack_price, snack_company) values('새콤달콤', 500, 2, '롯데');

-- 컬럼에 값 안넣기 - 에러!, NOT NULL 때문에
insert into jun03_snack(snack_name, snack_number) values('마이쮸', 3);

-- (컬럼명, 컬럼명, ...) 안넣고 테이블 생성당시의 컬럼명 순서대로 넣는 방법도!
insert into jun03_snack values(값, 값, ...);
insert into jun03_snack values(4, '엄마손파이', '롯데', 4000);
----------------------------------------------------------------------
-- 테이블 지우고 
drop table jun03_snack cascade constraint purge;
-- 다시 테이블 생성해서 값 5개 정도 넣어봅시다!
insert into jun03_snack values(1, '오징어땅콩', '오리온', 1500);
insert into jun03_snack values(2, '다이제', '??', 2000);
insert into jun03_snack values(3, '포카칩', '농심', 1600);
insert into jun03_snack values(4, '고래밥', '오리온', 1500);
insert into jun03_snack values(5, '꽃게랑', '농심', 1500);

select * from jun03_snack;

-- 그런데... 5개 넣어서 하나하나씩 과자들 번호를 부여하면 됐는데
-- 과자의 종류가 상당히 다양하죠?
-- 과자 데이터 계속 넣다가 나중에 몇번인지 잊어버리면..? 
-- 데이터를 만들때마다 과자의 번호가 자동으로 계산이 되었으면 좋겠음 !

-- factory pattern이라고 해서 말 그대로 공장화 시스템!
-- MySQL : Autoincrement 옵션 
-- 현재 우리가 사용하는 OracleDB에서는 Sequence라는 것이 있음
--	  번호를 순서에 맞게 자동으로 생성해주는건데 
--    테이블과는 무관하고,
--	  단점으로는 insert에 실패해도 sequence 값은 무조건 올라감
--	  그리고, 증가된 값을 다시 내릴 수 없다 	 

-- sequence(table과는 무관한) 생성
create sequence [시퀀스명]; -- 간단한 시퀀스

-- 테이블명 뒤에 _seq를 붙여주는 문화가 있음
create sequence jun03_snack_seq;

-- 구체적인 시퀀스 
create sequence [시퀀스명]
	increment by 1			-- 증가값 (1씩 증가)
	start with 1			-- 시작값(1)
	minvalue 1 				-- 최소값(1)
	maxvalue 999 			-- 최대값(999)
	nocycle / cycle			-- 최대값에 도달하면 시작값부터 다시 반복할지 말지
	nocache / cache			-- 시퀀스를 미리 만들어놓고 메모리에서 가져다 쓸지말지
	noorder / order;		-- 요청 순서대로 값을 생성할지 말지
	
-- sequence 삭제
drop sequence [시퀀스명];
	
-- sequence 사용 : 시퀀스명.nextval
-- 기존에 있던 테이블 삭제했다가 다시 만들어서 값을 넣어봅시다!
insert into jun03_snack values(jun03_snack_seq.nextval, '포테토칩', '오리온', 1500);
insert into jun03_snack values(jun03_snack_seq.nextval, '다이제', '오리온', 2000);
insert into jun03_snack values(jun03_snack_seq.nextval, '썬칩', '???', 1600);
insert into jun03_snack values(jun03_snack_seq.nextval, '썬칩(실패)', '???', 9999999999); -- 시퀀스값은 insert에 실패해도 증가 
insert into jun03_snack values(jun03_snack_seq.nextval, '새콤달콤', '크라운', 500);

drop sequence jun03_snack_seq;

create sequence jun03_snack_seq;
select * from jun03_snack;

-- 이제 다시 테이블이랑 시퀀스 지워주고, 테이블 다시 만들 때 속성 추가!
--		(유통기한 Date)
create table jun03_snack(
	snack_number number(4) primary key,
	snack_name varchar2(10 char) not null,
	snack_company varchar2(10 char) not null,
	snack_price number(7) not null,
	snack_expiration_date date not null
);

create sequence jun03_snack_seq;

select sysdate from dual; -- dual : 연습용 더미 Table
insert into jun03_snack values(jun03_snack_seq.nextval, '새콤달콤 딸기맛','크라운', 500, sysdate);
drop table jun03_snack cascade constraint purge;

-- 특정시간 / 날짜
--		내장함수 - to_date('값', '패턴')
--		패턴(대문자) - YYYY, MM, DD, AM/PM, HH(12시간), HH24(추천), MI(분), SS(초)

insert into jun03_snack values(jun03_snack_seq.nextval, '새콤달콤 포도맛','크라운', 500, to_date('2024-06-07 14', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '죠리퐁','크라운', 1500, to_date('2024-06-08 18', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '메이플콘','크라운', 1700, to_date('2024-06-09 10', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '크라운산도','크라운', 2300, to_date('2024-06-09 15', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '꿀꽈배기','농심', 1600, to_date('2024-09-10 13', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '감자깡','농심', 1700, to_date('2024-10-12 23', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '새우깡','농심', 1700, to_date('2024-10-12 23', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '알새우칩','농심', 1600, to_date('2024-10-24 21', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '바나나킥','농심', 1700, to_date('2024-10-21 07', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '나쵸','오리온', 1600, to_date('2024-12-31 15', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '포카칩','오리온', 1700, to_date('2024-12-15 18', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '스윙칩','오리온', 1600, to_date('2024-09-10 23', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '초코칩쿠키','오리온', 1600, to_date('2024-08-27 14', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '허니버터칩','해태제과', 1800, to_date('2024-09-13 12', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '오예스','해태제과', 3000, to_date('2024-08-17 14', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '후렌치파이','해태제과', 1800, to_date('2024-11-16 10', 'YYYY-MM-DD HH24'));
insert into jun03_snack values(jun03_snack_seq.nextval, '홈런볼','해태제과', 1800, to_date('2024-12-14 02', 'YYYY-MM-DD HH24'));

select * from jun03_snack;
----------------------------------------------------------------------
-- R(Read)***
select [distinct] [컬럼명], [컬럼명 as 별칭 || 컬럼명 별칭], [연산자], [통계함수]
	from [테이블명]
	where [조건식]
	group by [그룹대상]
	having [함수 포함 조건]
	order by [정렬대상 asc/desc(오름차순 / 내림차순)]
-- 의 형태!

-- 과자테이블 전체 조회
-- '*' : 테이블 내의 모든 컬럼을 가져온다
select * from jun03_snack;

-- distinct : 중복 제거
select snack_company from jun03_snack;
select distinct snack_company from jun03_snack;

-- 컬러명은 그대로 컬럼명을 쓰면 되고,
-- 별칭 같은 경우... select문 안에서 숫자 계산이 가능한데 (+, -, *, /)
select snack_price / 100 from jun03_snack;
-- 컬럼명 자체가 snack_price/100 으로 나옴
-- 실제 프로그래밍 언어와 연동하다보면 컬럼명을 이용해서 값을 불러오는 경우가 있는데,
-- 별칭이라는 것을 써서 헷갈림을 방지하는 용도로 사용

-- as를 사용하는 방법
select snack_price / 100 as snack_price from jun03_snack;
-- 컬럼명 띄어쓰기하고 바로 별칭쓰는 방법 (V) - 자주 쓰임
select snack_price / 100 snack_price from jun03_snack;

-- 연산자! (산술연산자) 
-- Dual 테이블 ( 메모장 느낌 )
-- 	1. 오라클 자체에서 제공해주는 더미테이블
-- 	2. 간단하게 함수를 이용해서 계산 결과값을 확인할 때 사용하는 테이블

-- 13
select 1 + '3' from dual;
-- 4가 나옴!
-- 대부분 다른 언어들 같은 경우에는 '문자 우선' 13이라는 결과가 나오는데
-- 오라클에서는 반대로 '숫자 우선'**
-- 오라클 내에서는 연산자가 숫자만 연산 해줌

select 1 + 'a' from dual; -- 에러! (숫자로 바꿀수 없다는 에러 'invalid number')

-- 문자를 더해주기 위한 연산자가 따로 있는데 
-- 바로 '||' (shift + \)
select 1 || 'a'from dual;
select 1 || '3'from dual;







































