#!/usr/bin/env bash

set -e

#download data
pip install kaggle
KAGGLE_CONFIG_DIR=. kaggle datasets download yamaerenay/spotify-dataset-19212020-160k-tracks

#unzip data
mkdir -p dataset
unzip spotify-dataset-19212020-160k-tracks.zip -d dataset

#fix problems with artists data
sed -i 's/,,/,0,/g' dataset/artists.csv

#fetch and run mysql server with docker
docker pull mysql

if [ ! "$(docker ps -q -f name=some-mysql)" ]; then
  if [ "$(docker ps -aq -f status=exited -f name=some-mysql)" ]; then
        # cleanup
        docker rm some-mysql
  fi
  docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=secret-pw -d mysql:latest --secure-file-priv=/ 
# do note the --secure-file-priv argument. This sets the secure_file_priv sql variable, which indicates the directory from which batch input files can be read. By default, the docker mysql image sets this to null due to its config file at /etc/mysql/my.cnf. You can check its value in the mysql shell with:
# SHOW VARIABLES LIKE "secure_file_priv";
fi

#copy dataset and scripts into the mysql container
docker cp ./dataset/. some-mysql:/dataset/
docker cp queries.sql some-mysql:/
docker cp create_db.sql some-mysql:/

echo "waiting to connect to mysql server..."
sleep 10s
#create db and tables
docker exec -it some-mysql mysql -uroot --password=secret-pw -e "source create_db.sql"

#run queries
docker exec -it some-mysql mysql -uroot --password=secret-pw -e "source queries.sql"
