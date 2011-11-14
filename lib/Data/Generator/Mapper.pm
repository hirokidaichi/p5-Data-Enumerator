package Data::Generator::Mapper;
use strict;
use warnings;
use base qw/Data::Generator::Base/;

sub each {
    my ($self,$f ) = @_;
    my ($object,$mapper ) = @{ $self->object };
    $object->each(sub{
        my $value = shift;
        $f->($mapper->($value));
    });
}
1;
