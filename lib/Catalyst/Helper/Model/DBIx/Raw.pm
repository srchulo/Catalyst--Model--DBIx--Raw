package Catalyst::Helper::Model::DBIx::Raw;
use strict;
 
#ABSTRACT: Helper for DBIx::Raw Model

=head1 SYNOPSIS
 
  script/myapp_create.pl model Raw DBIx::Raw
 
=head1 DESCRIPTION
 
Helper for DBIx::Raw model
 
=method mk_compclass
 
=cut

sub mk_compclass {
  my ($self, $helper) = @_;
  my $file = $helper->{file};
  $helper->render_file('compclass', $file);
}
 
=head1 SEE ALSO
 
L<Catalyst::Manual>, L<Catalyst::Test>, L<Catalyst::Request>,
L<Catalyst::Response>, L<Catalyst::Helper>, L<Catalyst::Model::DBIx::Raw>
 
=cut
 
1;
 
__DATA__
=begin pod_to_ignore
 
__compclass__
package [% class %];
 
use strict;
use warnings;
 
use base qw/Catalyst::Model::DBIx::Raw/;
 
# 3-token (Signature) authentication
__PACKAGE__->config(
	dsn => 'dsn',
	user => 'user',
	password => 'password',
	conf => '/path/to/conf.pl',
	dbix_class_model => 'DB',
);

=end pod_to_ignore
 
=head1 NAME
 
[% class %] - Catalyst DBIx::Raw Model for [% app %]
 
=head1 SYNOPSIS
 
See L<[% app %]>
 
=head1 DESCRIPTION
 
Catalyst DBIx::Raw Model for [% app %]
 
=head1 AUTHOR
 
[% author %]
 
=head1 LICENSE
 
This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.
 
=cut
 
1;
