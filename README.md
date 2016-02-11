# cachectld-recipe

## 環境変数

|環境変数名|説明|
|:------|:------|
|AWS_ACCESS_KEY_ID|アクセスキー|
|AWS_SECRET_ACCESS_KEY|シークレットアクセスキー|
|AWS_SSH_KEY_ID|秘密鍵のID|

## awscliのインストールする

	pip install awscli
	aws configure

## test-kitchenの設定

	bundle install
	bundle exec kitchen init --driver=kitchen-ec2
	bundle exec kitchen list
	bundle exec kitchen create default-AmazonLinux-201509
	bundle exec kitchen converge
