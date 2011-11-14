package Data::Generator::Where;
use strict;
use warnings;
use base qw/Data::Generator::Base/;

sub each {
    my ( $self,$f ) = @_;
    my ($object,$filter ) = @{$self->object};
    $object->each(sub{
        my $value = shift;
        my $result = $filter->($value);
        return unless $result;
        return $result if $self->is_last( $result );
        return $result if $self->is_next( $result );
        return $f->( $value );
    });
    
}
1;

