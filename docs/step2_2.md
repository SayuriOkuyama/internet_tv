# ステップ1で設計したテーブルを構築します
## テーブル作成の基本構文
基本構文は以下の通り。

```sql
CREATE TABLE <テーブル名>
(<列名1><データ型><列の制約>,
<列名2><データ型><列の制約>,
……
<テーブルの制約1>,<テーブルの制約2>, …);
```

## 設計したテーブル
- テーブル：channels
    | カラム名 | データ型 | キー | NOT NULL | デフォルト値 | オートインクリメント |
    | --- | --- | --- | --- | --- | --- |
    | cannel_no | INTEGER | PK | 〇 |  | 〇 |
    | cannel_name | VARCHAR(50) | UK | 〇 |  |  |

- テーブル：programs
    | カラム名 | データ型 | キー | NOT NULL | デフォルト値 | オートインクリメント |
    | --- | --- | --- | --- | --- | --- |
    | program_no | INTEGER | PK | 〇 |  | 〇 |
    | program_name | VARCHAR(100) | UK | 〇 |  |  |
    | program_detail | VARCHAR(500) |  | 〇 |  |  |

- テーブル：genres
    | カラム名 | データ型 | キー | NOT NULL | デフォルト値 | オートインクリメント |
    | --- | --- | --- | --- | --- | --- |
    | genre_no | INTEGER | PK | 〇 |  | 〇 |
    | genre_name | VARCHAR(20) | UK | 〇 |  |  |

- テーブル：episodes
    | カラム名 | データ型 | キー | NOT NULL | デフォルト値 | オートインクリメント |
    | --- | --- | --- | --- | --- | --- |
    | episode_index | INTEGER | PK | 〇 |  | 〇 |
    | program_no | INTEGER |  | 〇 |  |  |
    | season_no | INTEGER |  |  |  |  |
    | episode_no | INTEGER |  |  |  |  |
    | episode_name | VARCHAR(100) | UK | 〇 |  |  |
    | episode_detail | VARCHAR(500) |  | 〇 |  |  |
    | video_length | TIME |  | 〇 |  |  |
    | publication_at | DATE |  | 〇 |  |  |
    | viewers | INTEGER |  | 〇 | 0 |  |
    UNIQUE KEY (program_no, season_no, episode_no),
    FOREIGN KEY (program_no) REFERENCES programs(program_no)

- テーブル：program_genres
    | カラム名 | データ型 | キー | NOT NULL | デフォルト値 | オートインクリメント |
    | --- | --- | --- | --- | --- | --- |
    | program_no | INTEGER |  | 〇 |  |  |
    | genre_no | INTEGER |  | 〇 |  |  |
    PRIMARY KEY (program_no, genre_no),
    FOREIGN KEY (program_no) REFERENCES programs(program_no),
    FOREIGN KEY (genre_no) REFERENCES genres(genre_no)

- テーブル：program_schedules
    | カラム名 | データ型 | キー | NOT NULL | デフォルト値 | オートインクリメント |
    | --- | --- | --- | --- | --- | --- |
    | cannel_no | INTEGER |  | 〇 |  |  |
    | broadcasting_at | DATETIME |  | 〇 |  |  |
    | episode_index | INTEGER |  | 〇 |  |  |
    PRIMARY KEY (channel_no, broadcasting_at),
    FOREIGN KEY (channel_no) REFERENCES channels(channel_no),
    FOREIGN KEY (episode_index) REFERENCES episodes(episode_index)

## SQL 文の作成
上記のテーブル定義書をもとに、CREATE 文を作る。
直接ターミナルに打ち込まずに、VSCodeなどのエディタで入力してから、コピペすると入力しやすい。

- テーブル：channels
    
    ```sql
    CREATE TABLE channels (
        channel_no INTEGER NOT NULL AUTO_INCREMENT,
        channel_name VARCHAR(50) NOT NULL UNIQUE KEY,
        PRIMARY KEY (channel_no)
    );
    ```
    

- テーブル：genres
    
    ```sql
    CREATE TABLE genres (
        genre_no INTEGER NOT NULL AUTO_INCREMENT,
        genre_name VARCHAR(20) NOT NULL UNIQUE KEY,
        PRIMARY KEY (genre_no)
    );
    ```
    

- テーブル：programs
    
    ```sql
    CREATE TABLE programs (
        program_no INTEGER NOT NULL AUTO_INCREMENT,
        program_name VARCHAR(100) NOT NULL UNIQUE KEY,
        program_detail VARCHAR(500) NOT NULL,
        PRIMARY KEY (program_no)
    );
    ```
    

- テーブル：episodes
    
    ```sql
    CREATE TABLE episodes (
        episode_index INTEGER NOT NULL AUTO_INCREMENT,
        program_no INTEGER NOT NULL,
        season_no INTEGER,
        episode_no INTEGER,
        episode_name VARCHAR(100) NOT NULL UNIQUE KEY,
        episode_detail VARCHAR(500) NOT NULL,
        video_length TIME NOT NULL,
        publication_at DATE NOT NULL,
        viewers INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (episode_index),
        UNIQUE KEY (program_no, season_no, episode_no),
        FOREIGN KEY (program_no) REFERENCES programs(program_no)
    );
    ```
    

- テーブル：genres_of_program
    
    ```sql
    CREATE TABLE program_genres (
        program_no INTEGER NOT NULL,
        genre_no INTEGER NOT NULL,
        PRIMARY KEY (program_no, genre_no),
        FOREIGN KEY (program_no) REFERENCES programs(program_no),
        FOREIGN KEY (genre_no) REFERENCES genres(genre_no)
    );
    ```
    

- テーブル：program_schedules
    
    ```sql
    CREATE TABLE program_schedules (
        channel_no INTEGER NOT NULL,
        broadcasting_at DATETIME NOT NULL,
        episode_index INTEGER NOT NULL,
        PRIMARY KEY (channel_no, broadcasting_at),
        FOREIGN KEY (channel_no) REFERENCES channels(channel_no),
        FOREIGN KEY (episode_index) REFERENCES episodes(episode_index)
    );
    ```
    

## 使用するデータベースを指定
`use <データベース名>;` を実行し、使用するデータベースを指定。

```sql
use internet_tv;
```


## SQL 文の実行
1. 作った SQL 文をターミナルにそれぞれコピペし、実行。
    
2.  テーブル一覧を確認。
    
    ```sql
    SHOW TABLES;
    ```
    
    
3. 各テーブルのカラムを確認。
    
    ```sql
    SHOW COLUMNS FROM <テーブル名>;
    ```
    
