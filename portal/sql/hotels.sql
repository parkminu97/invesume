--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.9
-- Dumped by pg_dump version 9.5.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: tbl_board; Type: TABLE; Schema: public; Owner: ivs
--

CREATE TABLE tbl_board (
    no bigint NOT NULL,
    board_gubun character varying(1) NOT NULL,
    subject character varying(1000) NOT NULL,
    content text,
    event_start_date character varying(10),
    event_end_date character varying(10),
    rep_img character varying(200),
    read_hit integer,
    insert_dt timestamp without time zone,
    u_no bigint
);


ALTER TABLE tbl_board OWNER TO ivs;

--
-- Name: TABLE tbl_board; Type: COMMENT; Schema: public; Owner: ivs
--

COMMENT ON TABLE tbl_board IS '공지사항';


--
-- Name: tbl_hotel_guest_user_info; Type: TABLE; Schema: public; Owner: ivs
--

CREATE TABLE tbl_hotel_guest_user_info (
    guest_no bigint NOT NULL,
    hotel_no bigint NOT NULL,
    guest_id character varying(20) NOT NULL,
    guest_nm character varying(50),
    guest_pwd character varying(300) NOT NULL,
    guest_email character varying(300),
    insert_dt timestamp without time zone,
    update_dt timestamp without time zone,
    guest_draw character varying(2) DEFAULT 'N'::character varying
);


ALTER TABLE tbl_hotel_guest_user_info OWNER TO ivs;

--
-- Name: TABLE tbl_hotel_guest_user_info; Type: COMMENT; Schema: public; Owner: ivs
--

COMMENT ON TABLE tbl_hotel_guest_user_info IS '호텔별 투숙객 계정 정보';


--
-- Name: tbl_hotel_guest_user_info_guest_no_seq; Type: SEQUENCE; Schema: public; Owner: ivs
--

CREATE SEQUENCE tbl_hotel_guest_user_info_guest_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tbl_hotel_guest_user_info_guest_no_seq OWNER TO ivs;

--
-- Name: tbl_hotel_guest_user_info_guest_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ivs
--

ALTER SEQUENCE tbl_hotel_guest_user_info_guest_no_seq OWNED BY tbl_hotel_guest_user_info.guest_no;


--
-- Name: tbl_hotel_info; Type: TABLE; Schema: public; Owner: ivs
--

CREATE TABLE tbl_hotel_info (
    u_no bigint NOT NULL,
    hotel_name character varying(50) NOT NULL,
    rep_email character varying(50),
    rep_tel character varying(20),
    country character varying(10),
    hotel_addr1 character varying(1000),
    hotel_addr2 character varying(1000),
    insert_dt timestamp without time zone,
    update_dt timestamp without time zone,
    rep_img character varying(200),
    use_menu character varying(200)
);


ALTER TABLE tbl_hotel_info OWNER TO ivs;

--
-- Name: TABLE tbl_hotel_info; Type: COMMENT; Schema: public; Owner: ivs
--

COMMENT ON TABLE tbl_hotel_info IS '호텔 상세 정보 관리';


--
-- Name: tbl_hotel_menu; Type: TABLE; Schema: public; Owner: ivs
--

CREATE TABLE tbl_hotel_menu (
    no bigint NOT NULL,
    menu_name character varying(20) NOT NULL,
    menu_desc character varying(2000)
);


ALTER TABLE tbl_hotel_menu OWNER TO ivs;

--
-- Name: TABLE tbl_hotel_menu; Type: COMMENT; Schema: public; Owner: ivs
--

COMMENT ON TABLE tbl_hotel_menu IS '모바일 매뉴 구성 관리';


--
-- Name: tbl_hotel_room_img; Type: TABLE; Schema: public; Owner: ivs
--

CREATE TABLE tbl_hotel_room_img (
    u_no bigint NOT NULL,
    ri_no bigint NOT NULL,
    no bigint NOT NULL,
    room_img character varying(200)
);


ALTER TABLE tbl_hotel_room_img OWNER TO ivs;

--
-- Name: TABLE tbl_hotel_room_img; Type: COMMENT; Schema: public; Owner: ivs
--

COMMENT ON TABLE tbl_hotel_room_img IS '호텔 객실 이미지';


--
-- Name: tbl_hotel_room_info; Type: TABLE; Schema: public; Owner: ivs
--

CREATE TABLE tbl_hotel_room_info (
    u_no bigint NOT NULL,
    no bigint NOT NULL,
    room_name character varying(50) NOT NULL,
    room_use_yn character varying(1),
    room_money character varying(20),
    room_people_rule character varying(50),
    room_position character varying(20),
    room_bed_type character varying(50),
    room_comp character varying(100),
    room_info character varying(2000),
    room_service character varying(2000),
    rep_room_img bigint,
    insert_dt timestamp without time zone,
    update_dt timestamp without time zone
);


ALTER TABLE tbl_hotel_room_info OWNER TO ivs;

--
-- Name: TABLE tbl_hotel_room_info; Type: COMMENT; Schema: public; Owner: ivs
--

COMMENT ON TABLE tbl_hotel_room_info IS '호텔 객실 정보';


--
-- Name: tbl_hotel_user_info; Type: TABLE; Schema: public; Owner: ivs
--

CREATE TABLE tbl_hotel_user_info (
    u_no bigint NOT NULL,
    id character varying(20) NOT NULL,
    name character varying(50) NOT NULL,
    pwd character varying(100) NOT NULL,
    auth character varying(1) NOT NULL
);


ALTER TABLE tbl_hotel_user_info OWNER TO ivs;

--
-- Name: TABLE tbl_hotel_user_info; Type: COMMENT; Schema: public; Owner: ivs
--

COMMENT ON TABLE tbl_hotel_user_info IS '호텔 프론트 계정 관리';


--
-- Name: tbl_portal_admin_info; Type: TABLE; Schema: public; Owner: ivs
--

CREATE TABLE tbl_portal_admin_info (
    id character varying(20) NOT NULL,
    pwd character varying(100) NOT NULL
);


ALTER TABLE tbl_portal_admin_info OWNER TO ivs;

--
-- Name: TABLE tbl_portal_admin_info; Type: COMMENT; Schema: public; Owner: ivs
--

COMMENT ON TABLE tbl_portal_admin_info IS '서비스 콘솔 관리자 계정 관리';


--
-- Name: tbl_portal_payment_info; Type: TABLE; Schema: public; Owner: ivs
--

CREATE TABLE tbl_portal_payment_info (
    u_no bigint NOT NULL,
    no bigint NOT NULL,
    util_service character varying(1) NOT NULL,
    util_service_name character varying(50) NOT NULL,
    pay_day timestamp without time zone,
    pay_type character varying(1),
    pay_money character varying(10),
    use_start_date character varying(10),
    use_end_date character varying(10),
    use_yn character varying(1),
    insert_dt timestamp without time zone
);


ALTER TABLE tbl_portal_payment_info OWNER TO ivs;

--
-- Name: TABLE tbl_portal_payment_info; Type: COMMENT; Schema: public; Owner: ivs
--

COMMENT ON TABLE tbl_portal_payment_info IS '결제 관리';


--
-- Name: tbl_portal_user_info; Type: TABLE; Schema: public; Owner: ivs
--

CREATE TABLE tbl_portal_user_info (
    no bigint NOT NULL,
    id character varying(20) NOT NULL,
    name character varying(50) NOT NULL,
    pwd character varying(100) NOT NULL,
    tel character varying(20) NOT NULL,
    email character varying(50),
    insert_dt timestamp without time zone,
    delete_dt timestamp without time zone
);


ALTER TABLE tbl_portal_user_info OWNER TO ivs;

--
-- Name: TABLE tbl_portal_user_info; Type: COMMENT; Schema: public; Owner: ivs
--

COMMENT ON TABLE tbl_portal_user_info IS '서비스 가입자(호텔) 정보';


--
-- Name: guest_no; Type: DEFAULT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_hotel_guest_user_info ALTER COLUMN guest_no SET DEFAULT nextval('tbl_hotel_guest_user_info_guest_no_seq'::regclass);


--
-- Data for Name: tbl_board; Type: TABLE DATA; Schema: public; Owner: ivs
--

COPY tbl_board (no, board_gubun, subject, content, event_start_date, event_end_date, rep_img, read_hit, insert_dt, u_no) FROM stdin;
1	H	테스트	<p>테스트&nbsp;</p>	\N	\N	\N	0	2017-11-01 01:16:18.353645	\N
2	H	공지합니다.	공지합니다.<p>&nbsp;</p>	\N	\N	\N	4	2017-11-02 19:47:38.736589	1
3	P	포털 공지사항	포털 공지사항<p>&nbsp;</p>	\N	\N	\N	9	2017-11-02 10:57:09.206913	\N
\.


--
-- Data for Name: tbl_hotel_guest_user_info; Type: TABLE DATA; Schema: public; Owner: ivs
--

COPY tbl_hotel_guest_user_info (guest_no, hotel_no, guest_id, guest_nm, guest_pwd, guest_email, insert_dt, update_dt, guest_draw) FROM stdin;
6	4	test	test	bUXLOHy3uNd6dszmBbcv6g==	test@email.com	\N	\N	Y
8	4	test44	한글	fAps3dgGZuB23LGl+iOwWg==	rwqe@email.com	\N	\N	Y
7	1	test2	test	us9zPQF6ORcaRiSdjwwXnw==	test@email.com	\N	\N	Y
9	4	coolpeace	유산균이살아있는쿨피스	11111111	im@cool.socool	2017-11-01 00:00:00	\N	N
10	0	test23	test23	ta/SgmF2p1PO4Yu9uMkI3w==	test23@email.com	\N	\N	Y
11	0	testtest	testtest	Hx3dM1+YMEIFsqx5OvQJwg==	test@email.com	\N	\N	Y
12	1	ttt	ttt	1iHZJCTYW4pZT5/vTHKFRw==	tttt@email.com	\N	\N	Y
13	1	guest	guest	sYGbfmDUnXjN/i5EXhZ28Q==	guest@email.com	\N	\N	Y
\.


--
-- Name: tbl_hotel_guest_user_info_guest_no_seq; Type: SEQUENCE SET; Schema: public; Owner: ivs
--

SELECT pg_catalog.setval('tbl_hotel_guest_user_info_guest_no_seq', 13, true);


--
-- Data for Name: tbl_hotel_info; Type: TABLE DATA; Schema: public; Owner: ivs
--

COPY tbl_hotel_info (u_no, hotel_name, rep_email, rep_tel, country, hotel_addr1, hotel_addr2, insert_dt, update_dt, rep_img, use_menu) FROM stdin;
2	testdemo						2017-10-31 00:38:38.74203	\N	\N	1,2,3,4,5,6,7
8	북호텔	bookHotel@zzang.good	01011112222	KR	서울시 도봉구 도봉역	도봉도보로 5분 도보거리	2017-11-02 02:39:58.262079	\N	\N	\N
1	그로스베너	admin@gv.com	01022223333	PH	Malabanias, Angeles City, Pampanga, 2009, Philippines	Don Juico Avenue (across SM Clark City)	2017-10-28 12:42:47.425425	2017-11-02 04:19:56.705027	/opt/tomcat/portal/upload_file/1/info/footer_logo.jpg	1,2,3,4,5,6,7
\.


--
-- Data for Name: tbl_hotel_menu; Type: TABLE DATA; Schema: public; Owner: ivs
--

COPY tbl_hotel_menu (no, menu_name, menu_desc) FROM stdin;
1	회원가입	일반,소셜 로그인을 통한 회원가입
2	호텔소개	호텔 관리자가 작성한 호텔소개
3	예약문의	호텔에 예약을 문의하고 대화
4	체크인	고객이 앱을 사용하기 위한 확인 요청
5	화상통화	프론트 데스크와 영상통화
6	요청하기	자동 번역된 메시지 대화 제공
7	픽드랍요청	서비스카 이용이 필요한 경우 위치 정보와 함께 전송
\.


--
-- Data for Name: tbl_hotel_room_img; Type: TABLE DATA; Schema: public; Owner: ivs
--

COPY tbl_hotel_room_img (u_no, ri_no, no, room_img) FROM stdin;
1	2	7	/opt/tomcat/portal/upload_file/room/room1.jpg
1	1	8	/opt/tomcat/portal/upload_file/room/room3.jpg
1	2	9	/opt/tomcat/portal/upload_file/room//2/room1.jpg
1	3	10	/opt/tomcat/portal/upload_file/room//3/440904fae97d1943c99387c69d89c9be.jpg
2	3	11	/opt/tomcat/portal/upload_file/room//3/15286-wet-light-bulb-1920x1080-photography-wallpaper.jpg
3	4	12	/opt/tomcat/portal/upload_file/room//4/hamonia_logo (1)2.png
1	2	13	/opt/tomcat/portal/upload_file/room//2/48ba7515db08d.jpg
4	5	14	/opt/tomcat/portal/upload_file/room//5/196112570_x.jpeg
4	5	15	/opt/tomcat/portal/upload_file/room//5/196112614_x.jpeg
4	5	16	/opt/tomcat/portal/upload_file/room//5/196112564_x.jpeg
4	6	17	/opt/tomcat/portal/upload_file/4/room/6/599d2f491c9195.53017625.JPG
4	6	18	/opt/tomcat/portal/upload_file/4/room/6/599d171cc6ab09.04219273.JPG
4	6	19	/opt/tomcat/portal/upload_file/4/room/6/599d171d9a6c69.36413788(1).JPG
4	6	20	/opt/tomcat/portal/upload_file/4/room/6/599d171d9a6c69.36413788.JPG
4	6	21	/opt/tomcat/portal/upload_file/4/room/6/599d171d2a4e80.74559544.JPG
4	6	22	/opt/tomcat/portal/upload_file/4/room/6/599d171d2a4e80.74559544(1).JPG
4	7	23	/opt/tomcat/portal/upload_file/4/room/7/Rainbow-Royal-Suite-Room-Bath-The-Prince-Parktower-Tokyo1-800x520.jpg
4	7	24	/opt/tomcat/portal/upload_file/4/room/7/Rainbow-Royal-Suite-Room-Living2-The-Prince-Parktower-Tokyo2-800x520.jpg
4	7	25	/opt/tomcat/portal/upload_file/4/room/7/196112594_x.jpeg
8	8	26	/opt/tomcat/portal/upload_file/8/room/8/6KfLqyE.gif
8	9	27	/opt/tomcat/portal/upload_file/8/room/9/599d1721428287.65000116.JPG
8	9	28	/opt/tomcat/portal/upload_file/8/room/9/599d1721194066.85023802.JPG
8	9	29	/opt/tomcat/portal/upload_file/8/room/9/599d17186905b1.04501506.JPG
8	9	30	/opt/tomcat/portal/upload_file/8/room/9/599d1755977f56.36521891.JPG
8	10	31	/opt/tomcat/portal/upload_file/8/room/10/Harbor-Royal-Suite-Room-1-The-Prince-Park-Tower-Tokyo1-800x520.jpg
8	10	32	/opt/tomcat/portal/upload_file/8/room/10/Harbor-Royal-Suite-Room-2-The-Prince-Park-Tower-Tokyo1-800x520.jpg
8	10	33	/opt/tomcat/portal/upload_file/8/room/10/Harbor-Royal-Suite-Room-3-The-Prince-Park-Tower-Tokyo1-800x520.jpg
8	10	34	/opt/tomcat/portal/upload_file/8/room/10/Rainbow-Royal-Suite-Room-Bed-The-Prince-Parktower-Tokyo1-800x520.jpg
8	10	35	/opt/tomcat/portal/upload_file/8/room/10/Rainbow-Royal-Suite-Room-Living1-The-Prince-Parktower-Tokyo1-800x520.jpg
\.


--
-- Data for Name: tbl_hotel_room_info; Type: TABLE DATA; Schema: public; Owner: ivs
--

COPY tbl_hotel_room_info (u_no, no, room_name, room_use_yn, room_money, room_people_rule, room_position, room_bed_type, room_comp, room_info, room_service, rep_room_img, insert_dt, update_dt) FROM stdin;
1	2	Standard	Y	3000	최대3인	해변	킹베드	TV, 드라이기, 냉장고	해변이 보이는 뷰	무료픽드롭, 세탁	7	2017-10-28 12:47:51.674448	\N
1	1	Suite	Y	5000	성인2인	7F	트윈	TV, 에어컨, 욕조	야경이 아름다운 방	무료픽업, 웰컴드링크	8	2017-10-28 12:44:14.180983	\N
2	3	test1	Y								11	2017-10-31 00:38:49.4551	\N
3	4	111	N								12	2017-10-31 00:40:24.664806	\N
8	8	도봉구로1	N	50000	숨겨진 방	비밀	온돌방	물침대1, 도넛방석1	호텔 주인이 숨어있는 비밀의 방입니다.\r\n찾으신 분께는 책 00권을 증정해 드립니다.	폐 속 공기를 줄게	\N	2017-11-02 02:42:13.919689	\N
8	9	독서실	Y	100000	2인	2층	sweet room	침대1 욕실1 TV1 PC2	학창시절 향수를 떠올릴 수 있는 인테리어로\r\n 연인이 이용하기 좋은 방입니다	와이파이 세면도구	\N	2017-11-02 02:45:05.79758	\N
8	10	같은과언니네지	Y	140000	성인2	2층	sweet room	침대1, 의자1, 벽4	아기자기한 인테리어로 구성된 머스트 잇 헤브 언 룸 입니다	와이파이	\N	2017-11-02 02:47:39.931534	\N
4	7	구수한방	Y	150000	3인실	우리집	Standard	온돌, 온수, 아궁이	따뜻합니다	뜨끈뜨끈한 옛날 구수한 누룽지를 제공합니다.	23	2017-11-02 01:17:20.913499	\N
4	6	참치없는참치김밥	Y	1000000	글로벌사회의다양성을추구하기위해100명이가능	100B	bed	바닥 천장 벽	사방이 콘크리트 벽으로 감싸고 있어 아늑함은 없으나 안전합니다	없음	17	2017-11-01 08:23:00.182174	\N
4	5	101호	Y	100000	1명	192F	not_bed	침대1, 의자1, 벽4	어두운 독방입니다.	어디에서도 체험할 수 없는 독방 투숙실 입니다.	14	2017-10-31 06:37:34.369829	\N
\.


--
-- Data for Name: tbl_hotel_user_info; Type: TABLE DATA; Schema: public; Owner: ivs
--

COPY tbl_hotel_user_info (u_no, id, name, pwd, auth) FROM stdin;
1	hadmin	John	B3bEVxHLWfjbXxnDkGGaDw==	U
2	test1	test1	cNUau3uMCdbP/1f+PuT1yw==	U
4	bbongddae	뽕따이	a0N3L7KpjfZdkdBwtRBa5lRnkrxxNYl9	A
8	gamebook	겜돌이	wGXroLlUZOgQcwgrMgQO7iscjSVSFiek	A
5	temp	temp1	2ujkPgyKsananU6jtBU6xQ==	A
\.


--
-- Data for Name: tbl_portal_admin_info; Type: TABLE DATA; Schema: public; Owner: ivs
--

COPY tbl_portal_admin_info (id, pwd) FROM stdin;
admin	PF4vIF3EC3Xhs1m4OKWy+g==
\.


--
-- Data for Name: tbl_portal_payment_info; Type: TABLE DATA; Schema: public; Owner: ivs
--

COPY tbl_portal_payment_info (u_no, no, util_service, util_service_name, pay_day, pay_type, pay_money, use_start_date, use_end_date, use_yn, insert_dt) FROM stdin;
1	1	2	Basic	2017-10-29 14:20:23.762234	0	30000	2017.10.29	2017.11.28	Y	2017-10-29 14:20:23.762234
2	2	1	Demo	2017-10-31 03:48:56.575226	0	0	2017.10.31	2017.11.15	Y	2017-10-31 03:48:56.575226
\.


--
-- Data for Name: tbl_portal_user_info; Type: TABLE DATA; Schema: public; Owner: ivs
--

COPY tbl_portal_user_info (no, id, name, pwd, tel, email, insert_dt, delete_dt) FROM stdin;
1	demo	데모사용자	4i2bg9MIAMmnUXXQbArBcA==	01011112222	demo@user.com	2017-10-28 12:40:20.242278	\N
2	testdemo	test	ueqKTTkaI50kmykHHBwDaw==	123123	test@emaiil.com	2017-10-31 00:38:25.440028	\N
3	testdemo2	testdemo2	ElG7DcyM8a4KXWAwU9dzOA==	123123	testdemo2@email.com	2017-10-31 00:40:14.179974	\N
4	thethe	옆구리터진김밥꽁다리	5HK4sg/lP3CQ+wtXaI7LihElr8f4qsk5	01011112222	thethewhy@gmail.com	2017-10-31 03:54:06.509752	\N
5	yhlee	이윤호	W6371gRNHvrby3M6cv8YeQ==	01096339209	yhlee@invesume.com	2017-10-31 07:25:58.714411	\N
6	kcptest	kcptest	kTzT1F8g2FsCKpLU6N5HSFUZUArqfI1S	01012341234	kcp@invesume.com	2017-10-31 07:53:03.434981	\N
7	mirai	최소연	dHcqdHaCe+eXkzDR4fLuZQ==	01012345678	mirai@invesume.com	2017-11-01 07:30:04.730815	\N
8	book	북	2nGtEJXCAj1KOzzZ5Z0xsQzkjfsamw58	01011112222	book@book.com	2017-11-02 02:37:12.03177	\N
9	gon1942	gon	Z8ZR+f+5hbYSXzH9iu4Kmg==	123123	31233123	2017-11-03 00:16:45.975775	\N
\.


--
-- Name: tbl_board_pkey; Type: CONSTRAINT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_board
    ADD CONSTRAINT tbl_board_pkey PRIMARY KEY (no);


--
-- Name: tbl_hotel_guest_user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_hotel_guest_user_info
    ADD CONSTRAINT tbl_hotel_guest_user_info_pkey PRIMARY KEY (guest_no);


--
-- Name: tbl_hotel_info_pkey; Type: CONSTRAINT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_hotel_info
    ADD CONSTRAINT tbl_hotel_info_pkey PRIMARY KEY (u_no);


--
-- Name: tbl_hotel_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_hotel_menu
    ADD CONSTRAINT tbl_hotel_menu_pkey PRIMARY KEY (no);


--
-- Name: tbl_hotel_room_img_pkey; Type: CONSTRAINT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_hotel_room_img
    ADD CONSTRAINT tbl_hotel_room_img_pkey PRIMARY KEY (u_no, ri_no, no);


--
-- Name: tbl_hotel_room_info_pkey; Type: CONSTRAINT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_hotel_room_info
    ADD CONSTRAINT tbl_hotel_room_info_pkey PRIMARY KEY (u_no, no);


--
-- Name: tbl_hotel_user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_hotel_user_info
    ADD CONSTRAINT tbl_hotel_user_info_pkey PRIMARY KEY (u_no);


--
-- Name: tbl_portal_admin_info_pkey; Type: CONSTRAINT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_portal_admin_info
    ADD CONSTRAINT tbl_portal_admin_info_pkey PRIMARY KEY (id);


--
-- Name: tbl_portal_payment_info_pkey; Type: CONSTRAINT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_portal_payment_info
    ADD CONSTRAINT tbl_portal_payment_info_pkey PRIMARY KEY (u_no, no);


--
-- Name: tbl_portal_user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: ivs
--

ALTER TABLE ONLY tbl_portal_user_info
    ADD CONSTRAINT tbl_portal_user_info_pkey PRIMARY KEY (no);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

