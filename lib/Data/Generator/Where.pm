package Data::Generator::Where;
use strict;
use warnings;
use base qw/Data::Generator::Base/;

sub iterator {
    my ( $self ) = @_;
    my ($object,$filter ) = @{$self->object};
    my $object_iterator = $object->iterator;
    return sub{
        while(1){
            my $value = $object_iterator->();
            return $self->LAST if $self->is_last( $value );
            my $result = $filter->($value);
            return $self->LAST if $self->is_last( $result );
            return $value if $result;
        }
    };
}


1;

