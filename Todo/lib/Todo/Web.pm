package Todo::Web;

use strict;
use warnings;
use utf8;
use Kossy;
use Log::Minimal;
use Todo::Service::DB;
use Todo::Service::Todo;
use JSON qw/decode_json/;

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
    $c->render('index.tx');
};

######## API
# read all
get '/api/todos' => sub {
    my ( $self, $c ) = @_;
    my $todos = Todo::Service::Todo::get_all();
    $c->render_json({
        status => 200,
        items => [map { $_->to_hash(); } @$todos],
    });
};

# create new one
post '/api/todos' => sub {
    my ( $self, $c ) = @_;

    my $new_todo = decode_json($c->req->content);
    my $todo = $new_todo->{todo};
    my $todo = Todo::Service::Todo::create({
        todo => $todo
    });
    $c->render_json($todo->to_hash);
    $c->res->status(201);
    return $c->res;
};

# update
router 'PUT' => '/api/todos/:id' => sub {
    my ( $self, $c ) = @_;

    my $id = $c->args->{id};
    my $todo = decode_json($c->req->content)->{todo};
    my $todo = Todo::Service::Todo::update({
        id => $id, 
        todo => $todo,
    });

    $c->render_json($todo->to_hash);
};

# delete
router 'DELETE' => '/api/todos/:id' => sub {
    my ( $self, $c ) = @_;

    my $id = $c->args->{id};
    Todo::Service::Todo::delete({
        id => $id
    });

    $c->res->status(204);
    return $c->res;
};

1;

