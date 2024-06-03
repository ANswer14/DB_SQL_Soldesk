-- 웹사이트에서 게시판에 대한 테이블과 이를 [참조하는] 댓글 테이블을 만드려고 함
-- 게시판 테이블에는 [작성자 / 게시판 글 내용 / 작성 시간]에 대한 부분이 있었으면
-- 댓글 테이블에는 [작성자 / 댓글 내용 / 작성 시간]에 대한 부분이 있었으면

-- 1. 테이블의 구조를 파악해서 게시판 테이블 만들기
-- 2. 테이블의 구조를 파악해서 댓글 테이블 만들기
--	[조건 : 참조 되는 테이블의 내용이 삭제되면 관련있는 댓글 내용도 삭제]
-- 3. 게시판 테이블에 값 2개 넣고 / 각 게시글마다 댓글 2개씩 넣기
--	[조건 : 날짜 관련한 값은 현재 날짜/시간으로 통일]
-- 4. 게시글 1번을 지웠을 때 관련 댓글들도 지워지는지 확인

create table post_table(
	p_no number(1) primary key,
	p_author varchar2(10 char) not null,
	p_plot varchar2 (100 char) not null,
	p_time date not null
);
drop table post_table cascade constraint purge;
insert into post_table values(1, '게시자1', '가나다라마바사아자차카타파하', sysdate);
insert into post_table values(2, '게시자2', 'abcdefghijklmnopqrstuvwxyz', sysdate);

select * from post_table;
create table comment_table(
	c_no number(1) primary key,
	p_no number(1), 
	foreign key(p_no) 
	references post_table(p_no) 
	on delete cascade,
	c_author varchar2(10 char)not null,
	c_plot varchar2(100 char)not null,
	c_time date not null
);
drop table comment_table cascade constraint purge;
insert into comment_table values(1, 1, '시청자1', '댓글1댓글1댓글1', sysdate);
insert into comment_table values(2, 1, '시청자2', '댓글1댓글1댓글1', sysdate);
insert into comment_table values(3, 2, '시청자3', '댓글2댓글2댓글2', sysdate);
insert into comment_table values(4, 2, '시청자4', '댓글2댓글2댓글2', sysdate);

select * from comment_table;	

delete from post_table where p_no = 1;




































