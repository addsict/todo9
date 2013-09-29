package Todonize::Model::Todo;

use strict;
use warnings;
use Class::Accessor::Lite (
    new => 1,
    rw => [qw/title is_done is_doing created_date updated_date/],
);

sub to_hash {
    my $self = shift;
    return {
        title => $self->title,
        is_done => $self->is_done,
    };
}

1;
