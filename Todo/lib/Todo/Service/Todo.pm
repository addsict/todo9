package Todo::Service::Todo;

use strict;
use warnings;
use Todo::Config;
use Todo::Service::DB;
use Todo::Model::Todo;
use Log::Minimal;

use constant DB_TABLE => 'todo'; 

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

sub teng {
    my $dbh = shift;
    $dbh = $dbh || dbh();
    Todo::Service::DB->new({
        dbh => $dbh
    });
}

# convert Teng::Row to Todo::Model::Todo
sub row_to_model {
    my $row = shift;
    return Todo::Model::Todo->new(
        id => $row->id,
        todo => $row->todo,
        updated_at => $row->updated_at,
        created_at => $row->created_at,
    );
}

sub get_all {
    my ($dbh) = @_;
    my @rows = teng($dbh)->search(DB_TABLE, {
    });
    return [map { Todo::Model::Todo->from_row($_) } @rows];
}

sub create {
    my ($attr, $dbh) = @_;
    my $row = teng($dbh)->insert(DB_TABLE, {
        todo => $attr->{todo},
    });
    return Todo::Model::Todo->from_row($row);
}

sub update {
    my ($attr, $dbh) = @_;
    teng($dbh)->update(DB_TABLE, {
        todo => $attr->{todo},
    }, {
        id => $attr->{id}
    });

    return Todo::Model::Todo->from_row(teng($dbh)->single(DB_TABLE, {
        id => $attr->{id}
    }));
}

sub delete {
    my ($attr, $dbh) = @_;
    teng($dbh)->delete(DB_TABLE, {
        id => $attr->{id}
    });
}

1;
