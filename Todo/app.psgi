use FindBin;
use lib "$FindBin::Bin/extlib/lib/perl5";
use lib "$FindBin::Bin/lib";
use File::Basename;
use Plack::Builder;
use Todo::Web;

my $root_dir = File::Basename::dirname(__FILE__);

my $app = Todo::Web->psgi($root_dir);
builder {
    enable 'ReverseProxy';
    enable 'Log::Minimal';
    enable 'Static',
        path => qr!^/(?:(?:css|js|img)/|favicon\.ico$)!,
        root => $root_dir . '/public';
    $app;
};

