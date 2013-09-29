package Todo::Config;

use Config::ENV 'PLACK_ENV', export => 'config';

config development => +{
    dsn => 'dbi:mysql:test:localhost',
    db_user => 'addsict',
    db_password => '',
};

1;
