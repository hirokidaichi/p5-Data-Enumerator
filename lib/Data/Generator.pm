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

Data::Generator - some iterator utilities for perl

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

Data::Generator is utilities for iteration and test data generation 
like itertools in python or C# IEnumerable.

This module is marked B<EXPERIMENTAL>. API could be changed without any notice.

=head2 pattern

to create an iterator by a provided list.

    my $gen = pattern(qw/a b c/);
    # $gen->list => ('a','b','c')

a generator can product another generator

    my $gen = pattern(qw/a b c/)->product(pattern(qw/x y/));
    # $gen->list
    #  ["a", "x"],
    #  ["a", "y"],
    #  ["b", "x"],
    #  ["b", "y"],
    #  ["c", "x"],
    #  ["c", "y"],


=head2 generator

to create all pattern of data structure which contains pattern.

    my $users = generator({
        sex      => pattern(qw/male female/),
        age      => range(10,90,5),
        category => pattern(qw/elf human dwarf gnome lizardman/)
    })
    
this code is a syntax sugar of the following code:

    my $user = pattern(qw/male female/)
        ->product( range(10,90,5) )
        ->product( pattern(qw/elf human dwarf gnome lizardman/))
        ->select(sub{
            +{ sex => $_[0]->[0],age => $_[0]->[1],category => $_[0]->[2]}
        });

so you can enumerate all pattern of users.

    $user->each(sub{
        my $user = shift;
        $ do stuff
    });

=head1 AUTHOR

Daichi Hiroki E<lt>hirokidaichi {at} gmail.comE<gt>

=head1 SEE ALSO


=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
