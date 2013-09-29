package Todo::Model::Todo;

use strict;
use warnings;
use Todo::Config;
use Log::Minimal;

use Class::Accessor::Lite (
    new => 1,
    ro => [qw(id todo created_at updated_at)],
);

# convert Teng::Row to Todo::Model::Todo
sub from_row {
    my ($class, $row) = @_;
    $class->new(
        id => $row->id,
        todo => $row->todo,
        updated_at => $row->updated_at,
        created_at => $row->created_at,
    );
}

sub to_hash {
    my $self = shift;
    +{
        id => $self->id,
        todo => $self->todo,
        created_at => $self->created_at,
        updated_at => $self->updated_at,
    };
}

1;
