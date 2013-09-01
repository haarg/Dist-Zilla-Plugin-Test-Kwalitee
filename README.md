# NAME

Dist::Zilla::Plugin::Test::Kwalitee - Release tests for kwalitee

# VERSION

version 2.07

# SYNOPSIS

In `dist.ini`:

    [Test::Kwalitee]
    skiptest=use_strict ; Don't test for strictness.

# DESCRIPTION

This is an extension of [Dist::Zilla::Plugin::InlineFiles](http://search.cpan.org/perldoc?Dist::Zilla::Plugin::InlineFiles), providing the
following file:

    xt/release/kwalitee.t - a standard Test::Kwalitee test

# AUTHORS

- Harley Pig <harleypig@gmail.com>
- Caleb Cushing <xenoterracide@gmail.com>
- Marcel Gruenauer <marcel@cpan.org>
- Kent Fredric <kentfredric@gmail.com>
- Karen Etheridge <ether@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Karen Etheridge.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
