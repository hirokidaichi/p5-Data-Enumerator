package Data::Generator::Mapper;
use strict;
use warnings;
use base qw/Data::Generator::Base/;

sub iterator {
    my ( $self ) = @_;
    my ($object,$mapper ) = @{$self->object};
    my $object_iter = $object->iterator;
    return sub{
        my $value = $object_iter->();
        return $self->LAST if $self->is_last( $value );
        return $mapper->( $value );
    }
}
1;
