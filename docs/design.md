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

    ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/e7d6ef01-ad29-47c5-92a3-7d3504f517ae/ad3da55e-c726-4fa8-bf76-a917c93f7f3a/Untitled.png)

2. データベースができていることを確認する。
    
    ```sql
    SHOW DATABASES;
    ```
    
    ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/e7d6ef01-ad29-47c5-92a3-7d3504f517ae/950a6d84-2df7-4346-9dd2-95c710baacc4/Untitled.png)
