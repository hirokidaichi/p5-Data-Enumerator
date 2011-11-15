use strict;
use Test::More;
use Data::Dump qw/pp/;
use Data::Generator qw/pattern/;
{
    my $hoge = pattern((1..3));
    my $fuga = $hoge->select(sub{$_[0]*2});
    ::is_deeply([$fuga->list],[2,4,6]);
}
{
    my $hoge = pattern((1..15));
    my $fuga = $hoge->limit(1,10);
    ::is_deeply([$fuga->list],[2..11]);
}
{
    my $hoge = pattern( 1 .. 3 )->product( pattern(qw/a b c/) );
    my $fuga = $hoge->select(
        sub {
            my ($value) = @_;
            $value->[1] .= 'hoge';
            return $value;
        }
    );
    ::is_deeply(
        [ $fuga->list ],
        [   [ 1, "ahoge" ],
            [ 1, "bhoge" ],
            [ 1, "choge" ],
            [ 2, "ahoge" ],
            [ 2, "bhoge" ],
            [ 2, "choge" ],
            [ 3, "ahoge" ],
            [ 3, "bhoge" ],
            [ 3, "choge" ],
        ],
    );
}
::done_testing;
