#
#===============================================================================
#
#         FILE:  02ebuilds_read.t
#
#  DESCRIPTION:  Test Gentoo::Portage Functionality
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Michael Cummings (), <mcummings@gentoo.org>
#      COMPANY:  Gentoo
#      VERSION:  1.0
#      CREATED:  05/09/06 14:36:47 EDT
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use Test::More qw(no_plan);
#tests => 5;




# Verify we can load Gentoo name space
BEGIN { use_ok(' Gentoo'); }

# Can we call new?
my $GC = Gentoo->new();
ok( defined($GC), 'new() works' );

my $portdir;
# Can we get the PORTDIR value?
ok(  $portdir = $GC->getEnv("PORTDIR"), 'getEnv("PORTDIR") worked' );

$GC->getAvailableEbuilds($portdir,'gnustep-base');
# Test getting the contents of a directory
ok( $GC->{packagelist}, 'Grabbed gnustep-base' );

$GC->{portage_categories} = [ "gnustep-base" ];
$GC->getAvailableVersions($portdir);
ok( $GC->{portage}, 'Digested available versions' );
foreach my $ebuild (keys %{$GC->{portage}} ) {
	ok($ebuild, '$ebuild has value');
	ok($GC->{portage}{$ebuild}, '$ebuild has version');
}
foreach my $ebuild (keys %{$GC->{portage}} ) {
	ok($GC->{portage}{$ebuild}{name}, "$ebuild name check");
	ok($GC->{portage}{$ebuild}{category}, "$ebuild category check");
}
