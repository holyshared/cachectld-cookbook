# cachectld-recipe

## awscliのインストールする

	pip install awscli
	aws configure

## test-kitchenの設定

	bundle install
	bundle exec kitchen init --driver=kitchen-ec2
	bundle exec kitchen list
	bundle exec kitchen create default-AmazonLinux-201509
	bundle exec kitchen converge
