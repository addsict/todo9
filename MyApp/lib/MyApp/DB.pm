package MyApp::DB;

use strict;
use warnings;
use MyApp::Config;
use Log::Minimal;
use DBI;

sub dbh {
    my $dsn = config->param('dsn');
    my $db_user = config->param('db_user');
    my $db_password = config->param('db_password');
    my $dbh = DBI->connect($dsn, $db_user, $db_password, {
        mysql_enable_utf8 => 1,
    });
    die $DBI::errstr
        unless defined $dbh;
    return $dbh;
}

1;
