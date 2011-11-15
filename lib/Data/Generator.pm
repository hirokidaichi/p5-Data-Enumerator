package Data::Generator;
use strict;
use warnings;
use Exporter qw/import/;
use Data::Generator::Base;
use Data::Generator::Array;
use Data::Generator::Deeply;
use Data::Generator::Range;
our @EXPORT_OK = qw/
    generator
    pattern
    range
    independ
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

sub independ {
    my ( $target ) = @_;
    return Data::Generator::Deeply::independ($target);
}
sub generator{
    my ( $target ) = @_;
    return Data::Generator::Deeply->compose($target);
}

sub range {
    my ( $start,$end,$succ) = @_;
    return Data::Generator::Range->new($start,$end,$succ);
}

1;
__END__

=head1 NAME

Data::Generator -

=head1 SYNOPSIS

    use Data::Generator qw/pattern generator/;

    my $cases = generator(
        {   hoge  => pattern(qw/a b c/),
            fuga  => pattern(qw/x y z/),
            fixed => 0
        }
    );

    for my $case ( $cases->list ){
           print pp($case);
    }

     # { hoge => 'a',fuga => 'x'}
     # { hoge => 'a',fuga => 'y'}
     # { hoge => 'a',fuga => 'z'}
     # { hoge => 'b',fuga => 'x'}
     # { hoge => 'b',fuga => 'y'}
     # { hoge => 'b',fuga => 'z'}
     # { hoge => 'c',fuga => 'x'}
     # { hoge => 'c',fuga => 'y'}
     # { hoge => 'c',fuga => 'z'}
     

=head1 DESCRIPTION

Data::Generator is

=head1 AUTHOR

Default Name E<lt>default {at} example.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
