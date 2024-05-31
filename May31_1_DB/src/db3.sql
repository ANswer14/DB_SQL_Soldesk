create table may31_coffee(
	c_name varchar2(10 char) primary key,
	c_price number(5) not null,
	c_kcal number(3) not null,
	c_start date not null
);

-- DDL에서 Create문을 다룰 수 있게 되었음 !
-- 이제 비교적 쉬운 alter / drop / truncate를 봅시다

insert into may31_coffee values ('아메리카노', 3000, 15, sysdate)

-- 데이터 타입 변경 / 컬럼의 크기(용량) 변경
alter table [테이블명] modify [컬럼명] [데이터타입(용량)];

-- 테이블 내에 값이 있는 상태에서 데이터타입을 변경하면 에러 !
alter table may31_coffee modify c_name number(3);
-- 테이블 내에 값이 있는 상태에서 용량을 이미 존재하는인스턴스보다 적게 변경하면 에러 !
alter table may31_coffee modify c_name varchar2(6 char);

-- 주의사항 : 데이터타입을 변경할 때는 해당 컬럼의 값을 모두 지워야 변경이 가능
--		그렇지 않으면 오류가 발생 !
--		컬럼의 용량을 줄이게 될 경우 해당 컬럼의 용량을 조회해서 
--		변경할 크기보다 큰 값이 있는지 확인하고 => 그 값을 변경 !

-- 컬럼명 변경
alter table [테이블명] rename column [기존 컬럼명] to [바꿀 컬럼명]
alter table may31_coffee rename column c_name to c_name2;

-- 컬럼 추가
alter table [테이블명] add [컬럼명] [데이터타입] [제약조건(생략가능)];

-- 기존에 값이 있는 상태에서 추가하면 오류
-- 기존의 데이터가 없어야 not null 가능
-- alter table may31_coffee add c_taste varchar2(20 char) not null;
alter table may31_coffee add c_taste varchar2(20 char);

-- 컬럼 삭제
alter table [테이블명] drop column [컬럼명];
alter table may31_coffee drop column c_taste;
-----------------------------------------------------------------------
-- 테이블 내의 내용 지우기
truncate table [테이블명];
truncate table may31_coffee;
select * from may31_coffee;
-- 테이블에 있는 데이터를 삭제하지만, 테이블의 구조 자체는 삭제하지 않음

-- 테이블 삭제 시 (휴지통에 넣기)
drop table [테이블명]; -- 몇몇 제약조건ㅇ이 걸려있을땐 삭제 X
drop table [테이블명] cascade constraint; -- 외래키 제약조건에도 삭제 O
drop table may31_coffee cascade constraint;
select * from may31_coffee;

-- 휴지통에 있는 테이블을 복원
flashback table[테이블명] to before drop;
flashback table may31_coffee to before drop;

-- 휴지통 비우기
purge recyclebin;

-- 휴지통에 넣기 + 비우기 = > 테이블 완전 삭제(휴지통에 저장되지 않음)
drop table [테이블명] cascade constraint purge;
drop table may31_coffee cascade constraint purge;
------------------------------------------------------------------------
-- DDL : 사실상 신입한테 맡기지 않음!
-- 경력있는 DBA들이 테이블을 만들어서 CRUD정도만 하게끔 할 것
































