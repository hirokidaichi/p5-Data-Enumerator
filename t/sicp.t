use strict;
use warnings;
use Test::More;
use List::MoreUtils qw/uniq/;
use Data::Generator qw/pattern generator/;
use Data::Dump qw/pp/;

my $try = generator(
    {   Baker    => pattern( 1 .. 5 ),
        Cooper   => pattern( 1 .. 5 ),
        Fletcher => pattern( 1 .. 5 ),
        Miller   => pattern( 1 .. 5 ),
        Smith    => pattern( 1 .. 5 ),
    }
    )->where(
    sub {
        my $value = shift;
        return if ( $value->{Baker} == 5 );
        return 1;
    }
    )->where(
    sub {
        my $value = shift;
        return if ( $value->{Cooper} == 1 );
        return 1;
    }
    )->where(
    sub {
        my $value = shift;
        return if ( $value->{Fletcher} == 1 );
        return if ( $value->{Fletcher} == 5 );
        return 1;
    }
    )->where(
    sub {
        my $value = shift;
        return unless ( $value->{Miller} > $value->{Cooper} );
        return 1;
    }
    )->where(
    sub {
        my $value = shift;
        return if ( abs( $value->{Smith} - $value->{Fletcher} ) == 1 );
        return 1;
    }
    )->where(
    sub {
        my $value = shift;
        return if ( abs( $value->{Fletcher} - $value->{Cooper} ) == 1 );
        return 1;

    }
    )->where(sub{
        my $value = shift;
        my @uv = uniq values %$value;
        return ( scalar @uv == 5 );
    })->select(
    sub {
        my $value = shift;
        my %value = %$value;
        [ @value{qw/Baker Cooper Fletcher Miller Smith/} ];
    }
    );

is_deeply( $try->list,[3,2,4,5,1]);
::done_testing;
