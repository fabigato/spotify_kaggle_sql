# README
this is an example application on how to process the spotify-dataset-19212020-160k-tracks dataset with an SQL db. Each step is documented in the main script run.sh but here's a high level summary of how this is achieved:
-download the dataset. It installs the kaggle python cli to do this. You need an API key, so one is included in this project
-the artists.csv file has some empty columns for some rows, so it fills them appropriately with the sed command
-pull the docker mysql image and run it, after checking it was not running already. A password is passed on the command line since security is not important for this purpose
-copy the dataset and sql scripts into the mysql container. The sql commands will be run from within that container so it will act as client, but using a separate client wouldn't be difficult. You could for instance start another container using the same image and link them so it can communicate with it:
`docker run -it --link mysql-tst:mysql-tst --rm mysql mysql -hmysql-tst -uroot -p`
or you could not link them and refer to it by IP, which you can retrieve with:
`docker inspect -f \
'{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
mysql-tst`
then you run the new container:
`docker run -it --rm mysql mysql -h<ip> -uroot -p`
-actually run the sql scripts, one to build and fill the database from the csv files, and another one to run actual queries


#visualizing the data
Mysql workbench is a very nice tool, you can import files and automatically create a table with it, check this out: https://stackoverflow.com/questions/9998596/create-mysql-table-directly-from-csv-file-using-the-csv-storage-engine
