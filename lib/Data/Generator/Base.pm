package Data::Generator::Base;
use strict;
use warnings;
use Scalar::Util qw/blessed/;
use UNIVERSAL::can;
use constant LAST => bless {},'Data::Generator::Base::LAST';
use constant NEXT => bless {},'Data::Generator::Base::NEXT';

sub new {
    my ( $class,$object) = @_;
    return bless {
        object => $object,
    },$class;
}

sub object {
    shift->{object}
}

sub is_last {
    return (ref $_[1] and ref $_[1] eq 'Data::Generator::Base::LAST');
}
sub is_next {
    return (ref $_[1] and ref $_[1] eq 'Data::Generator::Base::NEXT');
}

sub each {
    my ( $self,$f) = @_;
    my @list = @{$self->object};
    for my $value ( @list ) {
        my $result = $f->($value); 
        last if( $self->is_last( $result ) );
        next if( $self->is_next( $result ) );
    }
}

sub select {
    my ( $self,$mapper ) = @_;
    require Data::Generator::Mapper;
    return Data::Generator::Mapper->new([$self,$mapper]);
}

sub where {
    my ( $self,$predicate ) = @_;
    require Data::Generator::Where;
    return Data::Generator::Where->new([$self,$predicate]);
}

sub limit {
    my ( $self,$offset,$limit ) = @_;
    require Data::Generator::Limit;
    return Data::Generator::Limit->new([$self,$offset,$limit]);
}

sub add {
    my ( $self ,$generator ) = @_;
    require Data::Generator::Add;
    return Data::Generator::Add->new([$self,$generator]);
}

sub product {
    my ( $self,$generator) = @_;
    require Data::Generator::Product;
    return Data::Generator::Product->new([$self,$generator]);
}

sub from {
    my ( $proto,$generator ) = @_;
    $proto->product($generator ) if blessed $proto;
    return $generator;
}

sub list {
    my ( $self ) = @_;
    my @list;
    $self->each(sub{
        push @list ,shift;
    });
    return @list;
}

1;
