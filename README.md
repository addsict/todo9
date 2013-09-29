How to install
--------------
```sh
$ carton install
$ cp Todo/lib/Todo/{Config.pm.dist,Config.pm}
$ vi Todo/lib/Todo/Config.pm # edit MySQL configurations
$ mysql {DB_NAME} -u {DB_USER} -p {DB_PASSWORD} < Todo/etc/schema.sql
```

How to run
-----------
```sh
# in development
$ mysql.server start
$ carton exec -- plackup -r -E development Todo/app.psgi -p 5000

# in production
$ mysql.server start
$ carton exec -- plackup -E production Todo/app.psgi -p 5000
```

How to test
------------
```sh
$ carton exec -- prove -ITodo/lib Todo/t
```
