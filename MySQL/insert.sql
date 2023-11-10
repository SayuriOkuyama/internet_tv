-- チャンネルのサンプルデータ
INSERT INTO channels (channel_name)
VALUES 
('ドラマ1'), ('ドラマ2'), ('アニメ1'), ('アニメ2'), ('スポーツ1'), ('スポーツ2'), ('ペット'), ('ニュース1'), ('ニュース2'), ('映画1'), ('映画2'), ('バラエティ1'), ('バラエティ2'), ('音楽1'), ('音楽2'), ('ドキュメンタリー1'), ('ドキュメンタリー2'), ('教育1'), ('教育2');

-- 番組のサンプルデータ（番組数: 30）
INSERT INTO programs (program_name, program_detail)
SELECT 
    CONCAT('番組', number),
    CONCAT('番組番号', number, 'の詳細情報')
FROM 
    (SELECT 1 AS number UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30) AS numbers;

-- ジャンルのサンプルデータ
INSERT INTO genres (genre_name) VALUES
('アニメ'), ('ドラマ'), ('スポーツ'), ('ペット'), ('ニュース'), ('映画'), ('バラエティ'), ('音楽'), ('ドキュメンタリー'), ('教育');

-- 番組とジャンルの関連データ（各番組は1つ以上のジャンルに属する）
-- ランダムなジャンル番号（1から10までの範囲）
INSERT INTO program_genres (program_no, genre_no)
SELECT 
    p.program_no,
    FLOOR(RAND() * 10) + 1
FROM 
    programs p;

-- エピソードのサンプルデータ（各番組に1つ以上のエピソードを割り当てる）
-- ランダムなシーズン番号（1から5までの範囲、偶数番組の場合はシーズンを持つ）
-- ランダムなエピソード番号（1から20までの範囲、偶数番組の場合はエピソードを持つ）
-- ランダムな動画時間（10から39分までの範囲）
-- ランダムな公開日（過去1年分の範囲）
-- ランダムな視聴数（0から100000までの範囲）
-- 偶数番組にエピソードを割り当てる
-- programsテーブルからランダムに選ぶ -- 1つだけ選ぶ
INSERT INTO episodes (program_no, season_no, episode_no, episode_name, episode_detail, video_length, publication_at, viewers)
SELECT 
    p.program_no,
    IF(p.program_no % 2 = 0, FLOOR(RAND() * 5) + 1, NULL),
    IF(p.program_no % 2 = 0, FLOOR(RAND() * 20) + 1, NULL),
    CONCAT('エピソード', ep_count.number),
    CONCAT('エピソード', ep_count.number, 'の詳細情報'),
    CONCAT(FLOOR(RAND() * 30) + 10, '分'),
    TIMESTAMPADD(DAY, -FLOOR(RAND() * 365), CURDATE()),
    FLOOR(RAND() * 100000)
FROM 
    programs p
JOIN
    (SELECT 1 AS number UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20) AS ep_count
WHERE
    p.program_no % 2 = 0
ORDER BY RAND()
LIMIT 1;



LOAD DATA INFILE '/var/tmp/csv_data/program_schedules.csv'
INTO TABLE program_schedules
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

mysql -u username -p --local-infile=1
[mysqld]
local_infile=1

-- ランダムなチャンネル番号（1から20までの範囲）
-- ランダムな放送日時（現在時刻から24時間以内の範囲）
-- ランダムなエピソードインデックス（episodesテーブルのエピソード数内のランダムな数値）
-- 300レコードを挿入する場合（必要に応じて調整
INSERT INTO program_schedules (channel_no, broadcasting_at, episode_index)
SELECT 
    FLOOR(RAND() * 20) + 1, 
    TIMESTAMPADD(HOUR, FLOOR(RAND() * 24), TIMESTAMPADD(DAY, FLOOR(RAND() * (TIMESTAMPDIFF(DAY, CURDATE(), '2023-12-31') + 1)), CURDATE())),
    e.episode_index
FROM 
    (SELECT episode_index FROM episodes ORDER BY RAND() LIMIT 1) AS e
LIMIT 300;
