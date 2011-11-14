use strict;
use Test::More;
use Data::Dump qw/pp/;
use Data::Generator qw/
    pattern
/;


{
    my $b = pattern(1,2,3,4,5);
    is_deeply([$b->list],[1,2,3,4,5],'same value');
}
{
    my $b = pattern(1,[1],3,4,5);
    is_deeply([$b->list],[1,[1],3,4,5],'same value');
}

{
    my $a = pattern(  1, 2, 3, 4, 5  );
    my $b = pattern(  5, 4, 3, 2, 1  );
    is_deeply( [ $a->add($b)->list ], [ 1, 2, 3, 4, 5, 5, 4, 3, 2, 1 ] );
}
{
    my $a = pattern(  1, 2, 3, 4, 5  );
    my $b = pattern(  5, 4, 3, 2, 1  );
    is_deeply(
        [ $a->product($b)->list ],
        [   [ 1, 5 ], [ 1, 4 ], [ 1, 3 ], [ 1, 2 ], [ 1, 1 ], [ 2, 5 ],
            [ 2, 4 ], [ 2, 3 ], [ 2, 2 ], [ 2, 1 ], [ 3, 5 ], [ 3, 4 ],
            [ 3, 3 ], [ 3, 2 ], [ 3, 1 ], [ 4, 5 ], [ 4, 4 ], [ 4, 3 ],
            [ 4, 2 ], [ 4, 1 ], [ 5, 5 ], [ 5, 4 ], [ 5, 3 ], [ 5, 2 ],
            [ 5, 1 ],
        ],
    );
}
::done_testing;
