package Data::Generator::Hash;
use strict;
use warnings;
use base qw/Data::Generator::Base/;

sub each {
    my ( $self , $f ) = @_;
    my $hash = $self->object;
    for my $key ( keys %$hash ) {
        my $value = $hash->{$key};
        my $result = $f->([$key,$value]);
        last if $self->is_last( $result );
        next if $self->is_next( $result );
    }
}

1;
