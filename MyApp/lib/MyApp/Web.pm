package MyApp::Web;

use strict;
use warnings;
use utf8;
use Kossy;
use Todonize (
    plugins => [qw/User/],
);
use Log::Minimal;
use Data::Dumper;
use MyApp::DB;

use constant DB_TABLE => 'todo';

filter 'set_title' => sub {
    my $app = shift;
    sub {
        my ( $self, $c )  = @_;
        $c->stash->{site_name} = __PACKAGE__;
        $app->($self,$c);
    }
};

get '/' => [qw/set_title/] => sub {
    my ( $self, $c )  = @_;

    my $todo = Todonize->create(
        title => 'hello',
        is_done => 0,
        creator => 'yuuki'
    );
    my $dbh = MyApp::DB::dbh();
    my $todos = Todonize->search_by_creator($dbh, DB_TABLE, 'yuuki');
    infof $todos;

    $c->render('index.tx', { greeting => "Hello" });
};

get '/json' => sub {
    my ( $self, $c )  = @_;
    my $result = $c->req->validator([
        'q' => {
            default => 'Hello',
            rule => [
                [['CHOICE',qw/Hello Bye/],'Hello or Bye']
            ],
        }
    ]);
    $c->render_json({ greeting => $result->valid->get('q') });
};

1;

