# 3.サンプルデータを入れる
## CSVファイルを準備
データ量が多いテーブルについては、テーブル名と同じ名前の csv フォルダを作成し、その中にデータを保存してある。
今回は、MySQL/csv_data ディレクトリにある下記 4 つのファイルを使用する。
- programs.csv
- program_genres.csv
- episodes.csv
- program_schedules.csv

`SELECT @@GLOBAL.secure_file_priv;`を実行し、特定のディレクトリのファイルのみ読み込む設定がされているか確認。

パスが表示される場合は、そのディレクトリに上記CSVファイルを格納。もしくは、my.cnf などの設定ファイルで上記設定の方を変更する。

今回は、`@@GLOBAL.secure_file_priv` に設定されていた /var/lib/mysql-files/ ディレクトリにCSVファイルを保存した。

カレントディレクトリからのパスを指定する必要があるため、各ファイルまでのパスを確認しておく。

## データの挿入
### SQL文に直接データを記述する方法
cannels と genres 両テーブルのデータについては、少ないので直接クエリに記述する。

今回は、下記のチャンネルとジャンルをデータとして準備した。

※下記クエリは MySQL/insert.sql ファイルにも記述してある。

```sql
-- チャンネルのサンプルデータ
INSERT INTO channels (channel_name)
VALUES
('ドラマ'), ('アニメ'), ('スポーツ'), ('お笑い'),  ('音楽'), ('バラエティー');

-- ジャンルのサンプルデータ
INSERT INTO genres (genre_name) VALUES
('アニメ'), ('ドラマ'), ('スポーツ'), ('料理'), ('映画'), ('バラエティ'), ('音楽'), ('ドキュメンタリー'), ('教育'), ('お笑い');
```

上記クエリをそれぞれコピペして実行する。

### CSVファイルからデータをインポートする方法
`LOAD DATA INFILE` 構文を使う。

ファイルのパスは、自身の CSV ファイルへのパスに置き換える。

CSVファイルの各カラムのデータは `,` で区切っており、各レコードは改行で区切っているため、それぞれ `FIELDS TERMINATED BY` と `LINES TERMINATED BY` で指定。

１行目にはカラム名を記載しているため、その行を省いて読み込むように`IGNORE`で指定。

※下記クエリは MySQL/insert.sql ファイルにも記述してある。

```sql
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
```

上記クエリをそれぞれコピペし実行する。

これで、全テーブルにサンプルデータが挿入された。