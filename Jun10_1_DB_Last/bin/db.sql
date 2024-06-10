-- 어떤 특정한 식당에 대한 테이블
-- 식당 지점(체인점 지역), 식당 주인(이름), 좌석 수

-- 데이터 2-3개 정도 넣기
create table burgerking(
	b_location varchar2(10 char) primary key,
	b_ceo varchar2(10 char) not null,
	b_seat number(5) not null 
);
insert into burgerking values('강남점', '김이박', 300);
insert into burgerking values('산본점', '안안안', 200);
insert into burgerking values('판교점', '최최최', 80);

drop table burgerking cascade constraint purge;
select * from burgerking;

---------------------------------------------------------------
-- 예약 테이블
-- 예약자 이름, 예약 시간, 예약자 전화번호, 예약 지점

-- 데이터 2-3개 정도 넣기
create table reservation(
	r_no number(3) primary key,
	r_name varchar2(10 char) not null,
	r_time date not null,
	r_phone_number varchar2(20 char) not null,
	b_location varchar2(10 char) not null,
	constraint fk_b_location foreign key(b_location)
		references burgerking(b_location)
		on delete cascade
);
create sequence reservation_seq;
drop sequence reservation_seq;
insert into reservation values(reservation_seq.nextval, '최길동', to_date('2024-06-17 18:00', 'YYYY-MM-DD HH24:MI'), '010-1111-2222', '강남점');
insert into reservation values(reservation_seq.nextval, '김길동', to_date('2024-06-17 15:00', 'YYYY-MM-DD HH24:MI'), '010-2222-3333', '강남점');
insert into reservation values(reservation_seq.nextval, '박길동', to_date('2024-06-19 17:00', 'YYYY-MM-DD HH24:MI'), '010-3333-4444', '산본점');

select * from reservation;
















