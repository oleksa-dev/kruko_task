# README

### MVP realization of Barcodes Scanner

### First run project:
0. Clone project
1. Make shure that you have ``pgdata`` folder (with permitions to read and write) on the same directory as cloned ``kruko_task``. You can also set your own location to ``pgdata`` folder in ``/docker/docker-compose.yml`` (line: 30).
2. Run in console ``make alive``
3. Go to [http://0.0.0.0:3040](http://0.0.0.0:3040)
4. Create new user

### List of avilable barcodes:
- 0647460819
- 0095722179
- 0891190639
- 0610452091
- 0281550631
- 0830188127
- 0106977745
- 0593847858
- 0091622062
- 0999988646


### CSV files for testing (test.csv, empty.csv) are located in the project folder

### Commands:
- ``make run`` - start developing
- ``make down`` - stop the app
- ``make attach`` - watch logs
