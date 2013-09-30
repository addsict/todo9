package Todonize;

use strict;
use warnings;
use Log::Minimal;
use Todonize::Model::Todo;
use UNIVERSAL::require;

sub import {
    my $class = shift;
    my %args = @_;
    my @plugins = @{$args{plugins}};

    for my $plugin (@plugins) {
        $class->extend($plugin);
    };

    1;
}

# extend class with plugin
sub extend {
    my ($class, $plugin_name) = @_;
    my $plugin_class = 'Todonize::Plugin::' . $plugin_name;
    # load module dynamically
    $plugin_class->require;
    my @new_colms = $plugin_class->columns();

    # extend Todo class
    Todonize::Model::Todo->_extend_attrs(@new_colms);

    # extend Todonize class
    my @import_methods = $plugin_class->export();
    infof @import_methods;
    foreach my $method (@import_methods) {
        no strict 'refs';
        my $method_body = "$plugin_class::$method";
        *{"Todonize::$method"} = $method_body;
    }
}

sub create {
    my ($class, %args) = @_;
    my $todo = Todonize::Model::Todo->new(%args);
    return $todo->save();
}

1;
