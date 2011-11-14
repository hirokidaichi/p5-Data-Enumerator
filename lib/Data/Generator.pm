package Data::Generator;
use strict;
use warnings;
use Exporter qw/import/;
use Data::Visitor::Callback;
use Data::Generator::Base;
use Data::Generator::Array;


our @EXPORT_OK = qw/
    generator
    pattern
    EACH_LAST
    EACH_NEXT
/;

our $VERSION = '0.01';

sub EACH_LAST {
    Data::Generator::Base->LAST;
}
sub EACH_NEXT {
    Data::Generator::Base->NEXT;
}

sub pattern {
    return Data::Generator::Array->new(\@_);
}


sub generator{
    
}



1;
__END__

=head1 NAME

Data::Generator -

=head1 SYNOPSIS

    use Data::Generator qw/
        

    /;
    my $data = make_generator({
        make
    });

=head1 DESCRIPTION

Data::Generator is

=head1 AUTHOR

Default Name E<lt>default {at} example.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
