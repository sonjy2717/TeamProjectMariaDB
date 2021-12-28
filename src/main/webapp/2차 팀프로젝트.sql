/*****************
2차프로젝트
******************/
#board 테이블 생성
CREATE TABLE board (
    idx INT PRIMARY KEY AUTO_INCREMENT,
    id VARCHAR(10) NOT NULL, 
    title VARCHAR(200) NOT NULL, 
    content TEXT NOT NULL, 
    postdate DATETIME DEFAULT CURRENT_TIMESTAMP, 
    ofile VARCHAR(200), 
    sfile VARCHAR(30), 
    visitcount SMALLINT DEFAULT 0 NOT NULL,
    tname VARCHAR(10),
    calDate VARCHAR(20)
);


#member 테이블 생성
CREATE TABLE member (
    name VARCHAR(30) NOT NULL,
    id VARCHAR(10) PRIMARY KEY, 
    pass VARCHAR(10) NOT NULL, 
    num VARCHAR(20),
    phone_num VARCHAR(20) NOT NULL, 
    email VARCHAR(50) NOT NULL,
    postcode INT(10) NOT NULL, 
    basicadd VARCHAR(100) NOT NULL, 
    detailadd VARCHAR(100) NOT NULL,
    regidate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
);

#외래키 설정
ALTER TABLE board ADD constraint fk_board_member
	FOREIGN KEY (id) references member (id);

#member테이블 날짜 컬럼 추가
alter table member add regidate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL;
#board 테이블 calDate 컬럼 추가
alter table board add calDate VARCHAR(20);


#board 더미 데이터 입력
insert into board (id, title, content, postdate, visitcount, tname)
    values ('test1', '자유게시판', '내용1입니다', NOW(), 0, 'free');
insert into board (id, title, content, postdate, visitcount, tname)
    values ('test1', '직원게시판', '내용1입니다', NOW(), 0, 'step');
insert into board (id, title, content, postdate, visitcount, tname)
    values ('test1', '보호자게시판', '내용1입니다', NOW(), 0, 'guard');
insert into board (id, title, content, postdate, visitcount, tname)
    values ('test1', '자료게시판', '내용1입니다', NOW(), 0, 'file');
insert into board (id, title, content, postdate, visitcount, tname)
    values ('test1', '공지사항', '내용1입니다', NOW(), 0, 'notice');
insert into board (id, title, content, postdate, visitcount, tname)
    values ('test1', '사진게시판', '내용1입니다', NOW(), 0, 'photo');
insert into board (id, title, content, postdate, visitcount, tname)
    values ('test4', '정보자료실', '내용4입니다', NOW(), 0, 'info');
#insert into board (id, title, content, postdate, visitcount, tname)
    #values ('test4', '프로그램일정', '내용4입니다', NOW(), 0, 'schedule');
    
#member 더미 데이터 입력
insert into member values ('테스트1', 'test1', '1111', '02-1111-1111', 
    '010-1111-1111', 'test1@naver.com', 61085, '금천구', '가산동', NOW());
insert into member values ('테스트2', 'test2', '2222', '02-2222-2222', 
    '010-2222-2222', 'test2@gmail.com', 57382, '관악구', '봉천동', NOW());
insert into member values ('테스트3', 'test3', '3333', '02-3333-3333', 
    '010-3333-3333', 'test3@naver.com', 24584, '금천구', '독산동', NOW());
insert into member values ('테스트4', 'test4', '4444', '02-4444-4444', 
    '010-4444-4444', 'test4@naver.com', 21353, '금천구', '가산동', NOW());
    

#블루클리닝 견적의뢰 테이블 생성
CREATE TABLE blue_cleaning (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL, 
    bc_postcode INT(10) NOT NULL, 
    bc_basicadd VARCHAR(100) NOT NULL, 
    bc_detailadd VARCHAR(100) NOT NULL, 
    phone_num VARCHAR(30) NOT NULL, 
    email VARCHAR(50)NOT NULL, 
    bc_type VARCHAR(200) NOT NULL, 
    bc_space INT NOT NULL, 
    bc_date VARCHAR(10) NOT NULL, 
    regi_type VARCHAR(20) NOT NULL, 
    note VARCHAR(200) 
);

#제약조건 설정(외래키)
ALTER TABLE blue_cleaning
   ADD constraint bc_mem_fk 
   FOREIGN KEY (id)
   REFERENCES member (id);
   
#더미 데이터
insert into blue_cleaning
    values ('test1', '회사명1', 11111, '기본주소1', '상세주소1', '010-1111-1111', 'test1@naver.com',
            '청소종류1', 111, '2022-01-01', '예약신청', '기타 특이사항1');
insert into blue_cleaning
    values ('test2', '회사명2', 22222, '기본주소2', '상세주소2', '010-2222-2222', 'test2@naver.com',
            '청소종류2', 222, '2022-02-02', '견적문의', '기타 특이사항2');

#체험학습 신청 테이블 생성
CREATE TABLE field_trip (
    id VARCHAR(10) PRIMARY KEY, 
    name VARCHAR(100) NOT NULL, 
    phone_num VARCHAR(30) NOT NULL, 
    email VARCHAR(50) NOT NULL, 
    ft_cake INT NOT NULL,
    ft_cookie INT NOT NULL,
    ft_date VARCHAR(10) NOT NULL, 
    regi_type INT NOT NULL, 
    note VARCHAR(200) 
);

#제약조건 설정(외래키)
ALTER TABLE field_trip
   ADD constraint ft_mem_fk 
   FOREIGN KEY (id)
   REFERENCES member (id);

#체험학습 신청 더미 데이터
insert into field_trip
    values ('test1', '회사명1', '010-1111-1111', 'test1@naver.com',
            1, 1, '2022-01-01', 1, '기타 특이사항1');
insert into field_trip
    values ('test2', '회사명2', '010-2222-2222', 'test2@naver.csonjy2717om',
            2, 2, '2022-02-02', 2, '기타 특이사항2');

#쇼핑몰 구현 테이블

#상품관리 테이블
create table management (
    idx VARCHAR(10) PRIMARY KEY,
    img TEXT,
    name VARCHAR(30) NOT NULL,
    price INT NOT NULL,
    point INT,
    exp VARCHAR(100)
);

#더미 데이터
insert into management values('C01', 'chair01.jpeg', '의자1', 38000, 380, '맘모스가 앉아도 부셔지지 않는 의자');
insert into management values('C02', 'chair02.jpeg', '의자2', 38000, 380, '롯데타워 꼭대기에서 던져도 부셔지지 않는 의자');
insert into management values('D01', 'desk01.jpeg', '책상1', 58000, 580, '토르가 내려쳐도 부셔지지 않는 책상');
insert into management values('D02', 'desk02.jpeg', '책상2', 58000, 580, '비행기가 착륙해도 부셔지지 않는 책상');

#장바구니 테이블
CREATE TABLE basket (
    idx VARCHAR(10) PRIMARY KEY, 
    id VARCHAR(30) NOT NULL, 
    price INT NOT NULL, 
    count SMALLINT,
    total INT
);

INSERT INTO basket VALUES('D01', 'test1', 58000, 2, 116000);

#상품주문서 테이블
create table orderform (
    idx VARCHAR(10) NOT NULL,
    name VARCHAR(30) NOT NULL,
    postcode SMALLINT NOT NULL,
    basicadd VARCHAR(100) NOT NULL,
    detailadd VARCHAR(100) NOT NULL,
    phone_num VARCHAR(20) PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    message VARCHAR(50),
    payment SMALLINT NOT NULL
);
ALTER TABLE orderform MODIFY postcode INT;


#더미 데이터
insert into orderform 
    values ('C01', '손준영', 61085, '첨단2지구 부영 아파트', '111동 304호', '010-2700-1733', 'sonjy2717@naver.com', '배송메세지', 1);
insert into orderform 
    values ('C02', '이지현', 23875, '관악구', '봉천로', '010-2222-1333', 'sonjy2717@gmail.com', '배송메세지', 2);
    
#제약조건 설정(외래키)
ALTER TABLE orderform
   ADD constraint order_manage_fk
   FOREIGN KEY (idx)
   REFERENCES management (idx);
   
ALTER TABLE basket
   ADD constraint basket_manage_fk
   FOREIGN KEY (idx)
   REFERENCES management (idx);