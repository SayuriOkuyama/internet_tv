# インターネットTV

## 概要

好きな時間に好きな場所で話題の動画を無料で楽しめる「インターネットTVサービス」を新規に作成することになったと仮定。

データベース設計をした上で、データ取得する SQL を作成する。

## 仕様

- ドラマ1、ドラマ2、アニメ1、アニメ2、スポーツ、ペットなど、複数のチャンネルがある
- 各チャンネルの下では時間帯ごとに番組枠が1つ設定されており、番組が放映される
- 番組はシリーズになっているものと単発ものがある。シリーズになっているものはシーズンが1つものと、シーズン1、シーズン2のように複数シーズンのものがある。各シーズンの下では各エピソードが設定されている
- 再放送もあるため、ある番組が複数チャンネルの異なる番組枠で放映されることはある
- 番組の情報として、タイトル、番組詳細、ジャンルが画面上に表示される
- 各エピソードの情報として、シーズン数、エピソード数、タイトル、エピソード詳細、動画時間、公開日、視聴数が画面上に表示される。単発のエピソードの場合はシーズン数、エピソード数は表示されない
- ジャンルとしてアニメ、映画、ドラマ、ニュースなどがある。各番組は1つ以上のジャンルに属する
- KPIとして、チャンネルの番組枠のエピソードごとに視聴数を記録する。なお、一つのエピソードは複数の異なるチャンネル及び番組枠で放送されることがあるので、属するチャンネルの番組枠ごとに視聴数がどうだったかも追えるようにする

番組、シーズン、エピソードの関係について、以下のようなイメージとする（シリーズになっているものの例）。

- 番組：鬼滅の刃
- シーズン：1
- エピソード：1話、2話、...、26話

## ステップ1

テーブル設計をする。

テーブルごとにテーブル名、カラム名、データ型、NULL(NULL OK の場合のみ YES と記載)、キー（キーが存在する場合、PRIMARY/INDEX のどちらかを記載）、初期値（ある場合のみ記載）、AUTO INCREMENT（ある場合のみ YES と記載）を記載してください。また、外部キー制約、ユニークキー制約に関しても記載する。

その際に、少なくとも次のことを満たす。

- アプリケーションとして成立すること(プログラムを組んだ際に仕様を満たして動作すること)
- 正規化されていること

実際のテーブル設計は、docs/step1 ファイル参照。

## ステップ2

実際にテーブルを構築し、データを入れる。

その際の手順は、docs/step2~ファイルにそれぞれまとめてある。

## ステップ3

以下のデータを抽出するクエリを作成する。

クエリはdocs/step3 ファイルにまとめてある。

1. よく見られているエピソードを知りたい。
    
    エピソード視聴数トップ3のエピソードタイトルと視聴数を取得する。
    
2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたい。
    
    エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得する。
    
3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたい。
    
    本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得する。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとする。
    
4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたい。
    
    ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得する。
    
5. 直近一週間で最も見られた番組が知りたい。
    
    直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得する。
    
6. ジャンルごとの番組の視聴数ランキングを知りたい。
    
    番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得する。