-- 크롤링 결과 입력 테이블_인벤
create table mapleinven_list(
seq bigint primary key auto_increment, -- 기본키, 자동증가
title varchar(50), -- 제목, 문자열(최대 50자)
date varchar(50), -- 날짜, 문자열(최대 50자)
count int -- 카운트, 정수형
);

-- if) 테이블 삭제할 경우
DROP TABLE mapleinven_list;

-- 크롤링 결과_인벤 - 전체 데이터 조회
select * from mapleinven_list;

-- 일별 조회수 평균_인벤
SELECT date, ROUND(AVG(count), 0) AS avg_count
FROM mapleinven_list
GROUP BY date;

-- 일별 조회수 최대_인벤
SELECT date, ROUND(MAX(count), 0) AS max_count
FROM mapleinven_list
GROUP BY date;

-- [시간별 게시물을 일별로 변환]
SELECT
CASE
WHEN date LIKE '%:%' THEN '08-11' -- 패턴매칭, 특정날짜
ELSE date -- 원래 날짜
END AS grouped_date,
ROUND(AVG(count), 0) AS avg_count -- 평균, 반올림
FROM mapleinven_list
GROUP BY
CASE
WHEN date LIKE '%:%' THEN '08-11' -- 그룹핑 기준
ELSE date
END;

-- -----------------------------------------------------------

-- 크롤링 결과 입력 테이블_뉴스
create table maplenews_list(
seq bigint primary key auto_increment, -- 기본키, 자동증가
`index` int, -- 정수형 인덱스
title varchar(50) -- 제목, 문자열(최대 50자)
);

-- 열추가, 문자열(최대 50자)
ALTER TABLE maplenews_list
ADD COLUMN time VARCHAR(50);

-- 연관성이 낮은 검색 결과 필터링 (비고=X: 제외해야 할 내용)(*비고는 수동입력)
SELECT *
FROM maplenews_list ml
WHERE 비고 IS NULL;