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

::done_testing;
