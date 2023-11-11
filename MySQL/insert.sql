-- チャンネルのサンプルデータ
INSERT INTO channels (channel_name)
VALUES
('ドラマ'), ('アニメ'), ('スポーツ'), ('お笑い'),  ('音楽'), ('バラエティー');

-- ジャンルのサンプルデータ
INSERT INTO genres (genre_name) VALUES
('アニメ'), ('ドラマ'), ('スポーツ'), ('料理'), ('映画'), ('バラエティ'), ('音楽'), ('ドキュメンタリー'), ('教育'), ('お笑い');

-- プログラムのサンプルデータ(CSVファイルから挿入)
LOAD DATA INFILE '/var/lib/mysql-files/programs.csv'
INTO TABLE programs
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- プログラムとジャンルの関連性のサンプルデータ(CSVファイルから挿入)
LOAD DATA INFILE '/var/lib/mysql-files/program_genres.csv'
INTO TABLE program_genres
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- エピソードのサンプルデータ(CSVファイルから挿入)
LOAD DATA INFILE '/var/lib/mysql-files/episodes.csv'
INTO TABLE episodes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- プログラムスケジュールのサンプルデータ(CSVファイルから挿入)
LOAD DATA INFILE '/var/lib/mysql-files/program_schedules.csv'
INTO TABLE program_schedules
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;