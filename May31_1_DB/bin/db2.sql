-- 학생 테이블
create table student(
	student_id number(10),
	student_name varchar2(10 char),
	constraint pk_student primary key(student_id)
);

-- 교수 테이블
create table professor(
	professor_id number(10),
	professor_name varchar2(10 char),
	constraint pk_professor primary key(professor_id)
);

-- 강의 정보 테이블
create table course(
	course_id number(10),
	course_name varchar2(10 char),
	professor_id number(10),
	constraint pk_course primary key(course_id),
	constraint fk_course foreign key(professor_id)
		references professor(professor_id)
		on delete cascade
);

-- 수강 기록을 저장하는 테이블
create table enrollment(
	student_id number(10),
	course_id number(10),
	enrollment_date date,
	constraint pk_enrollment primary key(student_id, course_id),
	constraint fk_enrollment_student foreign key(student_id)
		references student(student_id)
		on delete cascade,
	constraint fk_enrollment_course foreign key(course_id)
		references course(course_id)
		on delete cascade
);

-- 학생 테이블에 데이터 넣기
insert into student values(1, '김학생');
insert into student values(2, '최학생');
select * from student;
select * from student;

-- 교수 테이블에 데이터 넣기
insert into professor values(1, '정교수');
insert into professor values(2, '오교수');

select * from professor;

-- 강의 테이블에 데이터 넣기
insert into course values(101, '스트리머각론', 1);
insert into course values(102, '아이돌개론', 2);
select * from course;

-- 수강 기록 테이블에 데이터 넣기
insert into enrollment values(1, 101, date '2024-05-30');
insert into enrollment values(2, 101, date '2024-05-31');
insert into enrollment values(1, 102, date '2024-06-1');
select * from enrollment;

-- student_id가 1인 학생을 삭제
delete from student where student_id = 1;

-- Enrollment 테이블 조회
select * from enrollment;

drop table enrollment cascade constraint purge;
drop table student cascade constraint purge;
drop table course cascade constraint purge;
drop table professor cascade constraint purge;




















