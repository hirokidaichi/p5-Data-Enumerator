use strict;
use warnings;
use Test::More;
use Data::Generator::File;
use Data::Dump qw/pp/;

my $f = Data::Generator::File->new('README');

open my $fh , '<','README';
my @f = <$fh>;
is( scalar $f->list ,scalar @f);
::done_testing;
