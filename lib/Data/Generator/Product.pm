package Data::Generator::Product;
use strict;
use warnings;
use base qw/Data::Generator::Base/;

sub each {
    my ( $self ,$f) = @_;
    my ($a,$b) = @{ $self->object };
    return $a->each(sub {
        my $a_value = shift;
        $b->each(sub{
            my $b_value = shift;
            $f->([$a_value,$b_value])
        })
    });
}
1;
