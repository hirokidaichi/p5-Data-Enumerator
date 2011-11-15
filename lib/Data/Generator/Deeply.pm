package Data::Generator::Deeply;
use strict;
use warnings;
use Data::Generator::Base;
use Data::Visitor::Callback;
{
    package Data::Generator::Deeply::_Swap;
    sub new {
        my ( $class,$id ) = @_;
        return bless \$id , $class;
    }
    sub value {
        my ( $self,$value ) = @_;
        return $value->[$self->id];
    }
    sub id{
        my ( $self ) = @_;
        $$self;
    }
}
{
    package Data::Generator::Deeply::_Fixed;
    use base qw/Data::Generator::Deeply::_Swap/;
    sub new {
        my ( $class,$generator ) = @_;
        return bless { generator => $generator } , $class;
    }
    sub _generator{
        shift->{generator};
    }
    sub value {
        my $value = shift->_iterator->();
        return if Data::Generator::Base->is_last($value);
        return $value;
    }
    sub _iterator {
        my ($self ) = @_;
        return $self->{_iterator} ||= $self->_generator->iterator;
    }
}
sub independ {
    return Data::Generator::Deeply::_Fixed->new($_[0]);
}

sub __swapper {
    my ( $id ) = @_;
    return Data::Generator::Deeply::_Swap->new($id);
}

sub __product_all {
    my ( @generators ) = @_;
    my $result = shift @generators;
    while( my $gen = shift @generators ) {
        $result = $result->product($gen);
    }
    return $result;
}

sub compose {
    my ( $class,    $struct ) = @_;
    my ( $template, $object ) = __get_template_and_generator($struct);
    return $object->select(sub{
        my $value = shift;
        __convert_by_template( $template,$value );
    });
}

sub __get_template_and_generator{
    my ( $struct ) = @_;
    my @generators;
    my $count = 0;
    my $v     = Data::Visitor::Callback->new(
        'object' => sub {
            my ( $v,$obj) = @_;
            if( $obj->isa('Data::Generator::Base')){
                push @generators,$obj;
                return __swapper( $count++);
            }
            return $obj;
        },

    );
    my $template  = $v->visit( $struct );
    my $producted = __product_all(@generators);
    return ($template,$producted);
}

sub __convert_by_template {
    my ( $template,$value ) = @_;
    my $v = Data::Visitor::Callback->new(
        'Data::Generator::Deeply::_Swap' => sub {
            my ( $v, $obj ) = @_;
            return $obj->value($value);
        },
    );
    return $v->visit($template);
}

1;
