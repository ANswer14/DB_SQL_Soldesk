-- 요식업 프랜차이즈 (참조간계 고려 X)

-- 홍콩반점 서초점은 홍길동이 운영하고 100석
-- 홍콩반점 종로점은 김길동이 운영하고 80석
-- 한신포차 강남점은 홍길동이 운영하고 150석
-- 부천포차 부천점은 최길동이 운영하고 130석
------------------------------------------------
-- 홍길동, 1990-03-03일생, 남자
-- 김길동, 1992-02-01일생, 여자
-- 홍길동, 1991-12-12일생, 여자
-- 최길동, 1989-09-01일생, 남자
------------------------------------------------
drop table jun05_restaurant cascade constraint purge;
create table jun05_restaurant(
	r_no number(3) primary key,
	r_name varchar2(4 char) not null,
	r_location varchar2(3 char) not null,
	r_ceo number(3) not null,
	r_seat number(3) not null
);
create sequence jun05_restaurant_seq;
drop sequence jun05_restaurant_seq;
select to_char(to_date('1990-03-03', 'YYYY-MM-DD'),'YYYY-MM-DD') from dual;
insert into jun05_restaurant values(jun05_restaurant_seq.nextval, '홍콩반점', '서초', 1, 100);
insert into jun05_restaurant values(jun05_restaurant_seq.nextval, '홍콩반점', '종로', 2, 80);
insert into jun05_restaurant values(jun05_restaurant_seq.nextval, '한신포차', '강남', 3, 150);
insert into jun05_restaurant values(jun05_restaurant_seq.nextval, '부천포차', '부천', 4, 130);
select * from jun05_restaurant;

drop table jun05_ceo cascade constraint purge;
create table jun05_ceo(
	c_no number(3) primary key,
	c_name varchar2(3 char) not null,
	c_birth varchar2(20 char) not null,
	c_gender varchar2(2 char) not null
);

create sequence jun05_ceo_seq;
insert into jun05_ceo values(jun05_ceo_seq.nextval, '홍길동', to_char(to_date('1990-03-03', 'YYYY-MM-DD'),'YYYY-MM-DD'),
'남자');
insert into jun05_ceo values(jun05_ceo_seq.nextval, '김길동', to_char(to_date('1992-02-01', 'YYYY-MM-DD'),'YYYY-MM-DD'),
'여자');
insert into jun05_ceo values(jun05_ceo_seq.nextval, '홍길동', to_char(to_date('1991-12-12', 'YYYY-MM-DD'),'YYYY-MM-DD'),
'여자');
insert into jun05_ceo values(jun05_ceo_seq.nextval, '최길동', to_char(to_date('1989-09-01', 'YYYY-MM-DD'),'YYYY-MM-DD'),
'남자');
select * from jun05_ceo;

drop table jun05_menu cascade constraint purge;
create table jun05_menu(
	m_no number(2) primary key,				-- 메뉴 번호
	m_name varchar2(10 char) not null,
	m_price number(5) not null,
	f_m_no number(3) not null 				-- 메뉴를 파는 식당의 번호
);
-- 짜장면, 5000원, 홍콩반점 서초점(100석) 에서 파는 
-- 불닭발, 12000원, 한신포차 강남점(150석) 에서 파는
-- ... 매장당 메뉴 5개 정도씩!

drop table jun05_menu cascade constraint purge;
create sequence jun05_menu_seq;
drop sequence jun05_menu_seq;
insert into jun05_menu values(jun05_menu_seq.nextval, '짜장면', 6000, 1);
insert into jun05_menu values(jun05_menu_seq.nextval, '짬뽕', 7000, 1);
insert into jun05_menu values(jun05_menu_seq.nextval, '간짜장', 7000, 1);
insert into jun05_menu values(jun05_menu_seq.nextval, '볶음밥', 6000, 1);
insert into jun05_menu values(jun05_menu_seq.nextval, '탕수육', 10000, 1);
insert into jun05_menu values(jun05_menu_seq.nextval, '짜장면', 6000, 2);
insert into jun05_menu values(jun05_menu_seq.nextval, '짬뽕', 7000, 2);
insert into jun05_menu values(jun05_menu_seq.nextval, '간짜장', 7000, 2);
insert into jun05_menu values(jun05_menu_seq.nextval, '볶음밥', 6000, 2);
insert into jun05_menu values(jun05_menu_seq.nextval, '탕수육', 10000, 2);
insert into jun05_menu values(jun05_menu_seq.nextval, '불닭발', 12000, 3);
insert into jun05_menu values(jun05_menu_seq.nextval, '통닭', 7000, 3);
insert into jun05_menu values(jun05_menu_seq.nextval, '파스타', 9000, 3);
insert into jun05_menu values(jun05_menu_seq.nextval, '떡볶이', 8000, 3);
insert into jun05_menu values(jun05_menu_seq.nextval, '계란찜', 8000, 3);
insert into jun05_menu values(jun05_menu_seq.nextval, '냉면', 8000, 4);
insert into jun05_menu values(jun05_menu_seq.nextval, '통닭', 7000, 4);
insert into jun05_menu values(jun05_menu_seq.nextval, '어묵탕', 8000, 4);
insert into jun05_menu values(jun05_menu_seq.nextval, '콘치즈', 8500, 4);
insert into jun05_menu values(jun05_menu_seq.nextval, '떡볶이', 7000, 4);
select * from jun05_menu;

delete from jun05_menu where f_no = 12;




































