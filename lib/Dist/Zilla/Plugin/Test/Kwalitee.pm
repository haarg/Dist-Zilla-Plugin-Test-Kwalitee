use 5.008;
use strict;
use warnings;

package Dist::Zilla::Plugin::Test::Kwalitee;
# ABSTRACT: Release tests for kwalitee
use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';
with 'Dist::Zilla::Role::TextTemplate';

sub mvp_multivalue_args { return qw( skiptest ) }

has skiptest => (
  is      => 'ro',
  isa     => 'ArrayRef[Str]',
  traits  => [ 'Array' ],
  default => sub { [] },
  handles => {
    push_skiptest => 'push'
  },
);

around add_file => sub {

  my ( $orig, $self, $file ) = @_;

  my $skiptests = q{eval "use Test::Kwalitee";};

  if ( @{ $self->skiptest } > 0 ) {

    my $skip = join ' ', map { "-$_" } @{ $self->skiptest };

    $skiptests = qq{eval {
  require Test::Kwalitee;
  Test::Kwalitee->import( tests => [ qw( $skip ) ]);
};
};

  }

  $self->$orig(
    Dist::Zilla::File::InMemory->new( {
      'name'    => $file->name,
      'content' => $self->fill_in_string( $file->content, { 'skiptests' => \$skiptests } ),
    } ),
  );
};

__PACKAGE__->meta->make_immutable;
no Moose;
1;

=begin :prelude

=for test_synopsis
1;
__END__

=end :prelude

=head1 SYNOPSIS

In C<dist.ini>:

    [Test::Kwalitee]
    skiptest=use_strict ; Don't test for strictness.

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following file:

  xt/release/kwalitee.t - a standard Test::Kwalitee test

=begin Pod::Coverage

  mvp_multivalue_args

=end Pod::Coverage

=cut

__DATA__
___[ xt/release/kwalitee.t ]___
#!perl

# This test is generated by Dist::Zilla::Plugin::Test::Kwalitee
use strict;
use warnings;
use Test::More;   # needed to provide plan.
{{ $skiptests }}

plan skip_all => "Test::Kwalitee required for testing kwalitee" if $@;
