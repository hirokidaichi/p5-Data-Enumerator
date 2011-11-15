use strict;
use Test::More;
use Data::Dump qw/pp/;
use Data::Generator qw/
    pattern
    generator
/;


my $pattern1 = pattern(qw/a b c/);
my $pattern2 = pattern(qw/x y z/);

my $gen = generator(
    {   p1 => $pattern1,
        p2 => [$pattern2],
        p3 => { x => [ pattern(qw/a b c/) ] }
    }
)->limit( 2, 5 );

is_deeply(
    [ $gen->list ],
    [   { p1 => "c", p2 => ["x"], p3 => { "x" => ["a"] } },
        { p1 => "a", p2 => ["x"], p3 => { "x" => ["b"] } },
        { p1 => "b", p2 => ["x"], p3 => { "x" => ["b"] } },
        { p1 => "c", p2 => ["x"], p3 => { "x" => ["b"] } },
        { p1 => "a", p2 => ["x"], p3 => { "x" => ["c"] } },
    ]
);
::done_testing;
