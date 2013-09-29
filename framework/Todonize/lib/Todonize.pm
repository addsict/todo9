package Todonize;

use strict;
use warnings;
use Log::Minimal;
use Todonize::Model::Todo;

sub create {
    my ($class, %args) = @_;
    return Todonize::Model::Todo->new(%args);
}

1;
