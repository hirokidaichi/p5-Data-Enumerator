package Data::Generator::Limit;
use strict;
use warnings;
use base qw/Data::Generator::Base/;

sub each {
    my ( $self ,$f) = @_;
    my ($object,$offset,$limit ) = @{$self->object};
    my $current_offset = 0;
    my $current_limit  = 0;
    $object->each(sub {
        my $value = shift;
        return $self->NEXT if( $current_offset++ < $offset );
        return $self->LAST if( $current_limit++ >= $limit );
        $f->($value);
    });
}
1;

