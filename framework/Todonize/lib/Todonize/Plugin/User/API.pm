package Todonize::Plugin::User::API;

use strict;
use warnings;
use parent qw/Todonize::Plugin/;
use Todonize::Model::Todo;
use Log::Minimal;
use Data::Dumper;

sub export {
    return qw(search_by_creator change_assignee);
}

sub columns {
    return qw(creator assignee);
}

sub search_by_creator {
    my ($todonize_class, $dbh, $table, $creator) = @_;
    my $rows = $dbh->selectall_arrayref("SELECT id FROM $table WHERE creator = ?", {}, $creator);

    return [map { Todonize::Model::Todo->from_row($_) } @$rows];
}

sub change_assignee {
    my ($todonize_class, $dbh, $table, $id, $new_assignee) = @_;
    Todonize->update($dbh, $table, $id, {
        assignee => $new_assignee,
    });
}

1;
