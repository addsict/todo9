package Todonize::Model::Todo;

use strict;
use warnings;
use Log::Minimal;
use Class::Accessor::Lite (
    new => 1,
    rw => [qw/title is_done is_doing created_date updated_date/],
);

our @extended_attrs;

sub to_hash {
    my $self = shift;
    my %hashed = (
        title => $self->title,
        is_done => $self->is_done,
    );
    foreach my $attr ($self->_extended_attrs()) {
        $hashed{$attr} = $self->{$attr}
    }
    return \%hashed;
}

sub _extend_attrs {
    my ($class, @attrs) = @_;
    Class::Accessor::Lite->mk_accessors(@attrs);

    push @class::extended_attrs, @attrs;
}

sub _extended_attrs {
    my $klass = shift;
    if (ref $klass) {
        my $class = ref $klass;
    } else {
        my $class = $klass;
    }
    return @class::extended_attrs;
}

sub from_row {
    my ($class, $row) = @_;
    return $class->new($row);
}

sub save {
    my $self = shift;

    # ここでDBに保存する

    return $self;
}

1;
