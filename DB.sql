=============== 오라클 ======================
-- coco 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS coco DEFAULT CHARACTER SET utf8;
USE `coco`;

-- 테이블 coco.bbs 구조 내보내기
CREATE TABLE bbs (
b_no NUMBER(11) NOT NULL PRIMARY KEY,
b_owner NUMBER(11) NOT NULL,
b_title VARCHAR2(50) NOT NULL,
b_content CLOB NOT NULL,
b_regdate TIMESTAMP NOT NULL);

KEY FK_bbs_user (b_owner),
CONSTRAINT FK_bbs_user FOREIGN KEY (b_owner) REFERENCES user (u_no)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- 테이블 데이터 coco.bbs:~0 rows (대략적) 내보내기
DELETE FROM `bbs`;
/*!40000 ALTER TABLE `bbs` DISABLE KEYS */;
INSERT INTO bbs (b_no, b_owner, b_title, b_content, b_regdate) VALUES
	(1, 1, '1', '2', CURRENT_TIMESTAMP);
INSERT INTO bbs (b_no, b_owner, b_title, b_content, b_regdate) VALUES    
	(2, 1, '테스트', '테스트', CURRENT_TIMESTAMP);
/*!40000 ALTER TABLE `bbs` ENABLE KEYS */;

-- 테이블 coco.user 구조 내보내기
CREATE TABLE member (
m_no NUMBER(11) NOT NULL PRIMARY KEY,
m_id VARCHAR2(50) NOT NULL,
m_pw VARCHAR2(255) NOT NULL
);

-- 테이블 데이터 coco.user:~2 rows (대략적) 내보내기
DELETE FROM member;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO member (m_no, m_id, m_pw) VALUES
	(1, 'ahn', '1111');
INSERT INTO member (m_no, m_id, m_pw) VALUES
	(2, 'art', '1111');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;



=============== MySQL ==================

-- --------------------------------------------------------
-- 호스트:                          localhost
-- 서버 버전:                        10.3.11-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- coco 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `coco` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `coco`;

-- 테이블 coco.bbs 구조 내보내기
CREATE TABLE IF NOT EXISTS `bbs` (
  `b_no` int(11) NOT NULL AUTO_INCREMENT,
  `b_owner` int(11) NOT NULL,
  `b_title` varchar(50) NOT NULL,
  `b_content` text NOT NULL,
  `b_regdate` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`b_no`),
  KEY `FK_bbs_user` (`b_owner`),
  CONSTRAINT `FK_bbs_user` FOREIGN KEY (`b_owner`) REFERENCES `user` (`u_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- 테이블 데이터 coco.bbs:~0 rows (대략적) 내보내기
DELETE FROM `bbs`;
/*!40000 ALTER TABLE `bbs` DISABLE KEYS */;
INSERT INTO `bbs` (`b_no`, `b_owner`, `b_title`, `b_content`, `b_regdate`) VALUES
	(1, 1, '1', '2', '2018-12-06 22:00:22'),
	(2, 1, '테스트', '테스트', '2018-12-06 22:10:26');
/*!40000 ALTER TABLE `bbs` ENABLE KEYS */;

-- 테이블 coco.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `u_no` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` varchar(50) NOT NULL,
  `u_pw` varchar(255) NOT NULL,
  PRIMARY KEY (`u_no`),
  UNIQUE KEY `u_id` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- 테이블 데이터 coco.user:~2 rows (대략적) 내보내기
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`u_no`, `u_id`, `u_pw`) VALUES
	(1, '1', '2'),
	(2, '2', '2');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

쇼핑몰 상품올리기 DB
CREATE TABLE `goods` (
`g_no` int(11) NOT NULL AUTO_INCREMENT,
`g_name` varchar(50) NOT NULL,
`g_price` varchar(50) NOT NULL,
`g_content` varchar(255) NOT NULL,
 PRIMARY KEY (`g_no`)
);
INSERT INTO `goods` (`g_no`, `g_name`, `g_price`,`g_content`) VALUES
	(1, '봄니트', '25000', '봄 기획상품'),
	(2, '댄디청바지', '55000', '봄 기획상품');
    

utf-8 문자셋 테이블
CREATE TABLE `study` (
  `no` int(11) NOT NULL,
  `sub` varchar(100) DEFAULT NULL,
  `writer` varchar(50) DEFAULT NULL,
  `writedate` date DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

문자셋 조회
show variables like 'c%';

테이블 문자셋 수정
alter table goods convert to character set utf8;
[출처] [MYSQL] 테이블, 컬럼 charset 변경|작성자 b1ix

create table test(...........) default character set utf8 collate utf8_general_ci ;

DB/ 테이블 데이터 타입 조회
SHOW CREATE DATABASE mydb;
show create table mytable;


CREATE TABLE `goods` (
`g_no` int(11) NOT NULL AUTO_INCREMENT,
`g_name` varchar(50) NOT NULL,
`g_price` varchar(50) NOT NULL,
`g_content` varchar(255) NOT NULL,
`g_date` date DEFAULT,
  PRIMARY KEY (`g_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

CREATE TABLE `user` (
`u_no` int(11) NOT NULL AUTO_INCREMENT,
`u_id` varchar(50) NOT NULL,
`u_pw` varchar(50) NOT NULL,
`u_date` DATE,
  PRIMARY KEY (`u_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;
=========== 날짜 자동 업데이트 ==================
CREATE
    TRIGGER user_OnInsert BEFORE INSERT
            ON user FOR EACH ROW
    SET
        NEW.u_date = NOW()
;
CREATE
    TRIGGER goods_OnInsert BEFORE INSERT
            ON goods FOR EACH ROW
    SET
        NEW.g_date = NOW()
;
=========== MySQL 테이블 컬럼 쿼리 ====================
테이블 생성
create table [테이블명](id int,name varchar(20));

컬럼 추가
alter table goods add g_date [타입] [옵션]; 
ex) alter table [테이블명] add [컬럼명] varchar(100) not null default '0'; 

컬럼 삭제
alter table [테이블명] drop [컬럼명];

컬럼명 변경 및 타입 변경
alter table [테이블명] change [컬럼명] [변경할컬럼명] varchar(12);

컬럼 타입 수정
alter table [테이블명] modify [컬럼명] varchar(14);

테이블명 수정
alter table [테이블명] rename [변경할테이블명];

테이블 삭제
drop table [테이블명];

컬럼값 수정
update user set level = 9 where u_id ='qq';



//상품 카테고리 테이블 생성
create table `goods_category` (
    `cateName` varchar(20)    not null,
    `cateCode` varchar(30)    not null,
    `cateCodeRef` varchar(30)    null,
    primary key(`cateCode`),
    foreign key(`cateCodeRef`) references `goods_category`(`cateCode`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

//참조테이블 완료
alter table `goods` add
    constraint `fk_goods_category`
    foreign key (`cateCode`)
    references `goods_category`(`cateCode`);

alter table goods add
    constraint fk_goods_category
    foreign key (cateCode)
    references goods_category(cateCode);

ALTER TABLE goods ADD
FOREIGN KEY (cateCode)
REFERENCES goods_category (cateCode);


alter table [ 테이블 이름 ] add
    constraint [ 제약조건 이름 ]
    foreign key ([ 참조할 컬럼 이름 ])
        references [ 참조되는 테이블 이름 ]([ 참조되는 컬럼 이름 ]);        


alter table `goods` add `cateCode` varchar(30) NOT NULL;
alter table `goods` add `g_amount` int(11) NOT NULL;
alter table `new_goods` add `g_amount` int(11);

insert into goods_category (cateName, cateCode) values ('아웃도어', '100');
insert into goods_category (cateName, cateCode, cateCodeRef) values ('자켓', '101','100');
insert into goods_category (cateName, cateCode, cateCodeRef) values ('패딩', '102','100');
insert into goods_category (cateName, cateCode, cateCodeRef) values ('점퍼', '103','100');
insert into goods_category (cateName, cateCode, cateCodeRef) values ('가디건', '104','100');
insert into goods_category (cateName, cateCode) values ('바지', '200');
insert into goods_category (cateName, cateCode) values ('스커트', '300');
insert into goods_category (cateName, cateCode) values ('신발', '400');


======== 참조 태이블 생성====================
CREATE TABLE `new_goods` (
`g_no` int(11) NOT NULL AUTO_INCREMENT,
`g_name` varchar(50) NOT NULL,
`g_price` varchar(50) NOT NULL,    
`g_content` varchar(1000) NOT NULL,
`g_date` date DEFAULT null,
`g_img` varchar(1000), 
`g_thum` varchar(200),    
`cateCode` varchar(30)  not null,    
  PRIMARY KEY (`g_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

create table `goods_category` (
    `cateName` varchar(20)    not null,
    `cateCode` varchar(30)    not null,
    `cateCodeRef` varchar(30)    null,
    primary key(`cateCode`),
    foreign key(`cateCodeRef`) references `goods_category`(`cateCode`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table new_goods add
    constraint fk_goods_category
    foreign key (cateCode)
    references goods_category(cateCode);

---------- 계층구조 쿼리------------------------

MySQL에서 계층형 쿼리 구문이 따로 없어 
함수를 만들어 재귀함수를 사용해 구현해본다.

ANIMAL 테이블을 생성한다.------------------

CREATE TABLE `ANIMAL` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`p_id` int(10) unsigned default '0',
`nm` varchar(50),
primary key(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
----------------------------
ANIMAL 테이블에 데이터를 넣어준다.------------------
insert into ANIMAL(p_id, nm) values ( 0, '동물');
insert into ANIMAL(p_id, nm) values ( 1, '말');
insert into ANIMAL(p_id, nm) values ( 1, '닭');
insert into ANIMAL(p_id, nm) values ( 2, '얼룩말');
insert into ANIMAL(p_id, nm) values ( 2, '조랑말');
insert into ANIMAL(p_id, nm) values ( 3, '흰닭');
insert into ANIMAL(p_id, nm) values ( 3, '검은닭');
insert into ANIMAL(p_id, nm) values ( 5, '망아지');
insert into ANIMAL(p_id, nm) values ( 6, '흰병아리');
insert into ANIMAL(p_id, nm) values ( 7, '검은병아리');
insert into ANIMAL(p_id, nm) values ( 9, '흰달걀');
insert into ANIMAL(p_id, nm) values ( 10, '검은달걀');

함수 fnc_hierarchi 를 만들어준다.---------------

DROP FUNCTION IF EXISTS fnc_hierarchi;
DELIMITER $$
CREATE FUNCTION  fnc_hierarchi() RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_id INT;
    DECLARE v_parent INT;    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;
    
    SET v_parent = @id;
    SET v_id = -1;
    
    IF @id IS NULL THEN
        RETURN NULL;
    END IF;
    
    LOOP
    
    SELECT MIN(id)
      INTO @id 
      FROM ANIMAL
     WHERE p_id = v_parent
       AND id > v_id;
    
    IF (@id IS NOT NULL) OR (v_parent = @start_with) THEN
       SET @level = @level + 1;
    RETURN @id;
    END IF;
    
    SET @level := @level - 1;
 
    SELECT id, p_id
      INTO v_id , v_parent 
        FROM ANIMAL
       WHERE id = v_parent;
   
    END LOOP;
 
END
 
$$
 
DELIMITER ;
-------------------------

조회  --------------------
SELECT CASE WHEN LEVEL-1 > 0 then CONCAT(CONCAT(REPEAT('    ', level  - 1),'┗'), ani.nm)
                 ELSE ani.nm
           END AS nm
     , ani.id
     , ani.p_id
     , fnc.level
  FROM
     (SELECT fnc_hierarchi() AS id, @level AS level
        FROM (SELECT @start_with:=0, @id:=@start_with, @level:=0) vars
          JOIN ANIMAL
         WHERE @id IS NOT NULL) fnc
  JOIN ANIMAL ani ON fnc.id = ani.id;
------------------------------


 SELECT level
        cateName,
        cateCode,
        cateCodeRef
   FROM goods_category 
CONNECT BY PRIOR cateCode = cateCodeRef 
  START WITH cateCodeRef = null;


select level, cateName, cateCode, cateCodeRef from goods_category
    start with cateCodeRef is null connect by prior cateCode = cateCodeRef;
    
=========== 상품리뷰 쓰기 DB =================    

create table g_reply (
    g_no      int(11)          not null,
    u_Id      varchar(50)    not null,
    reNum      int(11)          not null AUTO_INCREMENT,
    reCon      varchar(2000)  not null,
    reDate     date DEFAULT null,
    primary key(g_no, reNum) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table g_reply change reNum not null AUTO_INCREMENT;
create sequence tbl_reply_seq;

========= 참조 =========

alter table g_reply
    add constraint g_reply_g_no foreign key(g_no)
    references goods(g_no);
   
alter table g_reply
    add constraint g_reply_uId foreign key(u_id)
    references user(u_id);
    
    
<!-- 상품 소감(댓글) 작성 -->

insert into g_reply (g_no, u_Id, reCon)
     values (99, 'qq', '후기테스트')
         
<insert id="registReply">
 insert into g_reply (g_no, u_Id, reNum, reCon)
     values (#{gdsNum}, #{userId}, tbl_reply_seq.nextval, #{repCon})
</insert>
    
         
======== 카트 테이블을 생성 ==================
create table tbl_cart (
    cartNum     int(11)         not null AUTO_INCREMENT,
    u_Id      varchar(50)       not null,
    g_no      int(11)           not null,
    cartStock   int          not null,
    addDate     date            DEFAULT null,
    primary key(cartNum, u_Id) 
);
    
create sequence tbl_cart_seq;

         
========== 카트 테이블과 맴버 테이블, 상품 테이블을 참조 =========================      
alter table tbl_cart
    add constraint tbl_cart_userId foreign key(u_Id)
    references user(u_Id);

alter table tbl_cart
    add constraint tbl_cart_gdsNum foreign key(g_no)
    references goods(g_no);
         
========== 테스트 ==================
show create table tbl_cart;
         
insert into tbl_cart (cartNum, u_Id, g_no, cartStock, addDate)
     values (1, 'qq', 100,  99, now());
         
         
======== 테이블 별칭사용 조인 g_reply + user ==========
select r.g_no, r.u_Id, r.reNum, r.reCon, r.reDate, u.u_id 
		from g_reply r 
		inner join user u on r.u_Id = u.u_id 
		where g_no = 99;
         
         
         
         
======== 테이블 별칭사용 조인 tbl_cart + goods ==========

select  c.cartNum, c.u_id, c.g_no, c.cartStock, c.addDate, 
        g.g_no, g.g_price, g.g_thum 
		from tbl_cart c 
		inner join goods g on c.g_no = g.g_no
		where c.u_Id = 'qq';

------ rownum 사용 재정렬 ---------         
SET @rownum:=0;
select  @rownum:=@rownum+1 as no,
         c.cartNum, c.u_id, c.g_no, c.cartStock, c.addDate, 
        g.g_no, g.g_price, g.g_thum 
		from tbl_cart c 
		inner join goods g on c.g_no = g.g_no
		where c.u_Id = 'qq';
        
         
         <![CDATA[  ]]>
         
         
------ Mybatis ------------------
<select id="getData" fetchSize="30" resultType="java.util.HashMap" >
            select * from table
            where module='AB'
            <![CDATA[ AND ROWNUM <= 15 ]]>
         
         
</select>
         
------ 오라클 ------        
select row_numer() over(order by c.cartNum desc) as num,
        c.cartNum, c.u_id, c.g_no, c.cartStock, c.addDate, 
        g.g_no, g.g_price, g.thum 
		from tbl_cart c 
		inner join goods g on c.g_no = g.g_no
		where c.u_Id = 'qq';
         
================================================      
         
======== 주문 테이블 ===========================
create table tbl_order (
    orderId     varchar(50) not null,
    u_Id        varchar(50) not null,
    orderRec    varchar(50) not null,
    u_Addr1     varchar(20) not null,
    u_Addr2     varchar(50) not null,
    u_Addr3     varchar(50) not null,
    orderPhon   varchar(30) not null,
    amount      int         not null,
    orderDate   Date    DEFAULT null,
    primary key(orderId)
);
         
--- 주문 테이블과 맴버 테이블의 참조 설정
alter table tbl_order
    add constraint tbl_order_userId foreign key(u_Id)
    references user(u_id);
==== 주문 상세 테이블 ===============       
create table tbl_order_details (
    orderDetailsNum int          not null AUTO_INCREMENT,
    orderId         varchar(50)  not null,
    g_no            int          not null,
    cartStock       int          not null,
    primary key(orderDetailsNum)
);
---- 주문 상세 테이블과 주문 테이블의 참조 설정 ----
alter table tbl_order_details
    add constraint tbl_order_details_orderId foreign key(orderId)
    references tbl_order(orderId);

---- XML ------------
<!-- 주문 정보 -->
<insert id="orderInfo">
 insert into tbl_order(orderId, userId, orderRec, userAddr1, userAddr2, userAddr3, orderPhon, amount)
     values(#{orderId}, #{userId}, #{orderRec}, #{userAddr1}, #{userAddr2}, #{userAddr3}, #{orderPhon}, #{amount})
</insert>
   
<!-- 주문 상세 정보 --> 
<insert id="orderInfo_Details">
 insert into tbl_order_details(orderDetailsNum, orderId, gdsNum, cartStock)
     select tbl_order_details_seq.nextval, #{orderId}, gdsNum, cartStock
         from tbl_cart   
</insert>     
         
         
         
         
         
         
         