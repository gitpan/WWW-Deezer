# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl WWW-StreamSend.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Data::Dumper;

use Test::More tests => 5;
BEGIN { use_ok('WWW::Deezer::Artist') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $artist = new_ok('WWW::Deezer::Artist');

$artist = new_ok('WWW::Deezer::Artist' => [744]);

ok ($artist->name eq 'Nina Simone', 'Artist created correctly');

ok (! ref $artist->radio, 'Artist radio flag has correct (simple) type');
