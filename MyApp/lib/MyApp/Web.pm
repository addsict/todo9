package MyApp::Web;

use strict;
use warnings;
use utf8;
use Kossy;
use Todonize (
    plugins => [qw/User Fulltext/],
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

    my $dbh = MyApp::DB::dbh();
    # my $todo = Todonize->create({
        # title => '眠くない!!!!!!',
        # is_done => 0,
        # creator => '眠いさん',
        # assignee => 'furuyama'
    # }, $dbh, DB_TABLE);
    # my $todos = Todonize->search_by_creator($dbh, DB_TABLE, 'yuuki');
    # my $todos = Todonize->get_all($dbh, DB_TABLE);
    # infof $todos;
    # my $todo = Todonize->get($dbh, DB_TABLE, 1);
    # my $todo = Todonize->update($dbh, DB_TABLE, 16, {
        # creator => 'aaaaaaa'
    # });
    # infof $todo;
    # Todonize->delete($dbh, DB_TABLE, 5);
    # Todonize->change_assignee($dbh, DB_TABLE, 9, 'rosa');
    Todonize->search($dbh, DB_TABLE, 'rosa', 0, 10);

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

