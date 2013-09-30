package Todonize::Plugin::User;

use strict;
use warnings;
use parent qw/Todonize::Plugin/;
use Todonize::Model::Todo;
use Log::Minimal;
use Data::Dumper;

sub export {
    return qw(search_by_creator);
}

sub columns {
    return qw(creator assignee);
}

sub search_by_creator {
    my ($todonize_class, $dbh, $table, $creator) = @_;
    my $rows = $dbh->selectall_arrayref("SELECT id FROM $table WHERE creator = ?", {Slice => {}}, $creator);

    return [map { Todonize::Model::Todo->from_row($_) } @$rows];
}

1;
