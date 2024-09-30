#! /usr/bin/env perl

use strict;
use warnings;

use OpenSSL::Test qw/:DEFAULT/;
use OpenSSL::Test::Utils;

setup("test_default_ciphersuites");

plan tests => 6;

my @cipher_suites = ("DEFAULT_SUSE", "DEFAULT");

foreach my $cipherlist (@cipher_suites) {
  ok(run(app(["openssl", "ciphers", "-s", $cipherlist])),
     "openssl ciphers works with ciphersuite $cipherlist");
  ok(!grep(/(MD5|RC4|DES)/, run(app(["openssl", "ciphers", "-s", $cipherlist]), capture => 1)),
         "$cipherlist shouldn't contain MD5, DES or RC4\n");
  ok(grep(/(TLSv1.3)/, run(app(["openssl", "ciphers", "-tls1_3", "-s", "-v", $cipherlist]), capture => 1)),
         "$cipherlist should contain TLSv1.3 ciphers\n");
}

