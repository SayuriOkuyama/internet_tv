# 1.データベースを構築します

## MySQL への接続
テーブル作成が許可されたユーザーで MySQL に接続。
`mysql -u <ユーザー名> -p`
パスワードを求められるため、ユーザーのパスワードを入力。
（入力した文字は画面に表示されません）

## データベースの作成
1. `CREATE DATABASE <データベース名>;` を実行し、データベースを作成。
    今回は、テーブル名を internet_tv とする。

    ```sql
    CREATE DATABASE internet_tv;
    ```


2. データベースができていることを確認する。
    
    ```sql
    SHOW DATABASES;
    ```
    
