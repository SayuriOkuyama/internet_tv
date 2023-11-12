# ステップ３
データを抽出するクエリを作成する。

## 1.よく見られているエピソードを知りたい
エピソード視聴数トップ3のエピソードタイトルと視聴数を取得する。
```sql
SELECT
    episode_name AS "エピソードタイトル", viewers AS "視聴数"
FROM
    episodes
ORDER BY
	viewers DESC
LIMIT 3;
```

## 2.よく見られているエピソードの番組情報やシーズン情報も合わせて知りたい
エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得する。
```sql
SELECT
    p.program_name AS "番組名", season_no AS "シーズン数", e1.episode_no AS "エピソード数",
		e1.episode_name AS "エピソードタイトル", e1.viewers AS "視聴数"
FROM
    episodes AS e1 INNER JOIN programs AS p ON e1.program_no = p.program_no
ORDER BY
	viewers DESC
LIMIT 3;
```

## 3.本日の番組表を表示したい
本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたい。
本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得する。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとする。
```sql
SELECT
    c.channel_name AS "チャンネル名", ps.broadcasting_at AS "放送開始時刻",
		ADDTIME(TIME(ps.broadcasting_at), e.video_length) AS "放送終了時刻",
		e.season_no AS "シーズン数", e.episode_no AS "エピソード数",
		e.episode_name AS "エピソードタイトル", e.episode_detail AS "エピソード詳細"
FROM
    program_schedules AS ps INNER JOIN episodes AS e
			ON ps.episode_index = e.episode_index
		INNER JOIN channels AS c
			ON ps.channel_no = c.channel_no
WHERE
		DATE(ps.broadcasting_at) = CURDATE()
\G
```


## 4.ドラマのチャンネルの番組表を表示したい
ドラマというチャンネルがあったとして、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたい。
ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得する。
```sql
SELECT
    broadcasting_at AS "放送開始時刻", ADDTIME(TIME(ps.broadcasting_at), e.video_length) AS "放送終了時刻",
		e.season_no AS "シーズン数", e.episode_no AS "エピソード数", e.episode_name AS "エピソードタイトル",
		e.episode_detail AS "エピソード詳細"
FROM
    program_schedules AS ps INNER JOIN episodes AS e ON ps.episode_index = e.episode_index
WHERE
		DATE(ps.broadcasting_at) BETWEEN CURDATE() AND ADDDATE(CURDATE(), 7)
		AND channel_no = ( SELECT channel_no
												FROM channels
												WHERE channel_name = 'ドラマ'
											)
ORDER BY
	broadcasting_at ASC
\G
```

## 5.直近一週間で最も見られた番組が知りたい
直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得する。
```sql
SELECT
	p.program_name AS "番組タイトル", SUM(e.viewers) AS "視聴数"
FROM
  programs AS p INNER JOIN episodes AS e
     ON p.program_no = e.program_no
   INNER JOIN program_schedules AS ps
     ON ps.episode_index = e.episode_index
WHERE
  DATE(ps.broadcasting_at) BETWEEN ADDDATE(CURDATE(), -7) AND CURDATE()
GROUP BY
	p.program_name
ORDER BY
	SUM(e.viewers) DESc
LIMIT 2
;
```

## 6.ジャンルごとの番組の視聴数ランキングを知りたい
番組の視聴数ランキングはエピソードの平均視聴数ランキングとする。
ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得する。
### クエリ
```sql
SELECT
	g1.genre_name AS "ジャンル名",
	p1.program_name AS "番組タイトル",
	AVG(e1.viewers) AS "エピソード平均視聴数"
FROM
	programs AS p1
	INNER JOIN program_genres AS pg1
		ON p1.program_no = pg1.program_no
	INNER JOIN episodes AS e1
		ON p1.program_no = e1.program_no
	INNER JOIN genres AS g1
		ON pg1.genre_no = g1.genre_no
GROUP BY
	g1.genre_name, p1.program_name
HAVING
	AVG(e1.viewers) = ( SELECT
				MAX(e_sub.avg_viewers)
			FROM
				program_genres AS pg2
					INNER JOIN episodes AS e2
						ON pg2.program_no = e2.program_no
					INNER JOIN programs AS p2
						ON p2.program_no = e2.program_no
					INNER JOIN genres AS g2
						ON g2.program_no = e2.program_no
					INNER JOIN (
							SELECT
								e3.program_no,
								AVG(e3.viewers) AS avg_viewers
							FROM
								episodes AS e3
							GROUP BY
								e3.program_no
							) AS e_sub
						ON e2.program_no = e_sub.program_no
			WHERE
				g1.genre_name = g2.genre_name
			)
;
```

### 結果
| ジャンル名               | 番組タイトル                            | エピソード平均視聴数             |
|--------------------------|--------------------------------------|--------------------------------|
| ドラマ                   | ドラマ「シェフの花園」                  |                    115000.0000 |
| 料理                     | ドラマ「シェフの花園」                  |                    115000.0000 |
| 音楽                     | 音楽ライブ「響きの探求者」              |                    550000.0000 |
| お笑い                   | バラエティ「元気が出るテレビ」           |                     94500.0000 |
| 教育                     | 自然番組「美しい地球」                  |                     94500.0000 |
| ドキュメンタリー         | ドキュメンタリードラマ「実録・生きていく」  |                    101500.0000 |
| バラエティ               | バラエティ「人気者集合」                 |                    185000.0000 |
| アニメ                   | ファンタジーアニメ「冒険者たちの物語」    |                    107500.0000 |
| スポーツ                 | サッカー中継「ワールドカップ特集」        |                    125000.0000 |
| 映画                     | 映画「感動の物語」                      |                    102500.0000 |

10 rows in set (0.01 sec)