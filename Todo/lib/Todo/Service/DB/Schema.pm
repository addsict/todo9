package Todo::Service::DB::Schema;
use Teng::Schema::Declare;

table {
    name 'todo';
    pk 'id';
    columns qw( id todo created_at updated_at );
};

1;
