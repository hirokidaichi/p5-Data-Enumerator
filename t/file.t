use strict;
use warnings;
use Test::More;
use Data::Enumerator::File;
use Data::Dump qw/pp/;

my $f = Data::Enumerator::File->new('README');

open my $fh , '<','README';
my @f = <$fh>;
is( scalar $f->list ,scalar @f);
::done_testing;
