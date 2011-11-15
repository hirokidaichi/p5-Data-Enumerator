use strict;
use Test::More;
use Data::Dump qw/pp/;
use Data::Generator qw/pattern/;


{
    my $filter = pattern(  1 .. 20  )->where(
        sub {
            return ( $_[0] % 2 );
        }
    );
    ::ok $filter;
    is_deeply( [ $filter->list ], [ grep { $_ % 2 } ( 1 .. 20 ) ] );

}
::done_testing;
