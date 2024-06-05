select * from jun05_restaurant;
select * from jun05_ceo;
select * from jun05_menu;
----------------------------------------------------------------
-- 좌석 수 제일 많은 식당을 운영하는 사람의 전체 정보 조회
select * 
	from JUN05_CEO
	where c_no in
	(
	select r_ceo
	from jun05_restaurant
	where r_seat =
	(
	select max(r_seat)
	from jun05_restaurant
	)
	);
	
-- 메뉴 전체의 이름, 가격
--		을 가격 오름차순 => 가격이 같다면 메뉴명을 가나다 역순 정렬
-- 여러번 정렬 하고 싶을 때.. => order by 컬럼명 (ASC/DESC)**
select m_name, m_price from jun05_menu order by m_price, m_name desc;  

-- 전체 사장님들 이름, 생일 조회
select c_name, c_birth from jun05_ceo
	
-- 프랜차이즈 식당 몇 개 ? 
select count(*) from jun05_restaurant;
-- 프랜차이즈 메뉴 전체의 평균가
select avg(m_price) from jun05_menu;
----------------------------------------------------------------
-- 제일 비싼 메뉴 이름, 가격
select m_name, m_price
	from jun05_menu
	where m_price in
	(
	select max(m_price)
	from jun05_menu
	);
-- 최연장자 사장의 이름, 생일 (최연장자 = 최소 생일 값)
select c_name, c_birth
	from jun05_ceo
	where to_date(to_char(to_date(c_birth, 'YYYY-MM-DD'), 'YYYY'), 'YYYY') in
	(
	select min(to_date(to_char(to_date(c_birth, 'YYYY-MM-DD'), 'YYYY'), 'YYYY'))
	from jun05_ceo
	);

-- 좌석 수 제일 적은 식당의 이름, 지점명, 좌석 수
select r_name, r_location, r_seat
	from jun05_restaurant
	where r_seat in
	(
	select min(r_seat)
	from jun05_restaurant
	);
----------------------------------------------------------------
-- 홍콩반점 서초점을 운영하는 사람의 이름, 생일
select c_name, c_birth
	from jun05_ceo
	where c_no in
	(
	select r_ceo
	from jun05_restaurant
	where r_location in '서초' and r_name in'홍콩반점'
	);

-- '짜장'이 들어간 음식은 어디가면 먹을 수 있나요? (식당 이름, 지점명)
select r_name, r_location
	from jun05_restaurant
	where r_no in
	(
	select f_m_no
	from jun05_menu
	where m_name like '%짜장%'
	);
----------------------------------------------------------------
-- 최연소 사장님네 가게 메뉴 이름, 가격
select m_name, m_price
	from jun05_menu
	where f_m_no in
	(
	select r_no
	from jun05_restaurant
	where r_ceo in
	(
	select c_no
	from jun05_ceo
	where to_date(c_birth, 'YYYY-MM-DD') in
	(
	select max(to_date(c_birth, 'YYYY-MM-DD'))
	from jun05_ceo
	)
	)
	);

-- 최길동이 운영하는 가게의 모든 메뉴 이름, 가격, 사장님 생일
select m_name, m_price, (
						select c_birth
						from jun05_ceo
						where c_no in
						(
						select r_ceo
						from jun05_restaurant
						where r_no = f_m_no
						)
						
						)c_birthday
	from jun05_menu
	where f_m_no in
	(
	select r_no
	from jun05_restaurant
	where r_ceo in
	(
	select c_no
	from jun05_ceo
	where c_name = '최길동'
	)
	);

--------------------------------------------------------------------------------------------
-- 테이블 여러개를 'JOIN' 시킨다
--				: 테이블 여러개를 붙여서 RAM에 잠깐 넣어놓는...
--------------------------------------------------------------------------------------------
select * from jun05_restaurant, jun05_ceo;
-- 이렇게 테이블을 붙여서 사용이 가능하지만,
--	테이블들이 합쳐지면서 나타낼 수 있는 모든 값들을 나타내기 때문에
--	진짜 데이터들만 뽑아내려면 => 조건식을 사용해야 함
select * from jun05_restaurant, jun05_ceo where r_ceo = c_no;

-- 전체 식당 이름, 지점명, 사장님 이름, 사장님 생일
select r_name, r_location, c_name, c_birth
	from jun05_restaurant, jun05_ceo where r_ceo = c_no;
-- 전체 메뉴명, 가격, 식당 이름, 지점명
select m_name, m_price, r_name, r_location
	from jun05_menu, jun05_restaurant 
	where f_m_no = r_no;
-- 좌석수가 50석 이상인 식당의 메뉴명, 가격, 식당이름, 지점명, 좌석 수
select m_name, m_price, r_name, r_location, r_seat
	from jun05_menu, jun05_restaurant 
	where f_m_no in (
					select r_no
					from JUN05_RESTAURANT
					where r_seat >=50
					);
	
	
-- 규모가 제일 큰 식당의 메뉴명, 가격, 식당이름, 지점명, 좌석 수

-- 최연장자 사장님네 전체 메뉴명, 가격, 식당이름, 지점명, 사장님이름, 생일
--		을 메뉴명 가나다순 => 식당이름 가나다순





























