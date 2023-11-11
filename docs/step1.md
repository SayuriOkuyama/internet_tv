# ステップ１ テーブル設計

## テーブル定義
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
