package Todonize::Model::Todo;

use strict;
use warnings;
use Log::Minimal;
use Data::Dumper;
use Class::Accessor::Lite (
    new => 1,
    rw => [qw/id title is_done is_doing created_date updated_date/],
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
    infof Dumper $row;
    return $class->new($row);
}

sub save {
    my ($self, $dbh, $table) = @_;

    my @columns = grep { defined($self->{$_}) } keys($self->to_hash());
    my @values = map { $self->{$_} } @columns;

    unless (defined $self->id) {
        # create
        my $columns_stm = join ",", @columns;
        my $values_stm = join ",", map { '?' } @values;
        my $stm = "insert into $table ($columns_stm) values ($values_stm)";
        $dbh->do($stm, {}, @values);
    } else {
        # update
        my $set_stm = join ",", map { $_ . '=?' } @columns;
        my $stm = "update $table set $set_stm WHERE id = ?";
        infof $stm;
        $dbh->do($stm, {}, @values, $self->id);
    }

    return $self;
}

sub get {
    my ($class, $dbh, $table, $id) = @_;
    my $row = $dbh->selectrow_hashref("SELECT * FROM $table WHERE id = ?", {}, $id);
    return Todonize::Model::Todo->from_row($row);
}

sub get_all {
    my ($class, $dbh, $table) = @_;
    my $rows = $dbh->selectall_hashref("SELECT * FROM $table");

    return [map { Todonize::Model::Todo->from_row($_) } @$rows];
}

sub update {
    my ($class, $dbh, $table, $id, $args) = @_;
    my $todo = $class->get($dbh, $table, $id);
    infof Dumper $todo;
    foreach my $arg_key (keys %$args) {
        $todo->$arg_key($args->{$arg_key});
    }
    infof Dumper $todo;
    return $todo->save($dbh, $table);
}

sub delete {
    my ($class, $dbh, $table, $id) = @_;
    my $stm = "delete from $table where id = ?";
    infof $stm;
    $dbh->do($stm, {}, $id); 
}

1;
