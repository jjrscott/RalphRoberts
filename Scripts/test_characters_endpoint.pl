#!/usr/bin/perl

use strict;
use utf8;
use Data::Dumper;
use Digest::MD5 'md5_hex';
use JSON::PP;

my ($publicKey, $privateKey) = @ARGV;

if (!defined $privateKey)
{
	die qq($0 <public key> <private key>\n);
}

my $json = JSON::PP->new->canonical(1)->pretty(1)->relaxed(1)->allow_nonref();

my $ts = qx(uuidgen);

chomp $ts;

my $hash = md5_hex($ts.$privateKey.$publicKey);

my $command = qq(curl -s 'https://gateway.marvel.com/v1/public/characters?ts=${ts}&apikey=${publicKey}&hash=${hash}&limit=50');

print $command;
print "\n";
print "\n";

my $data = qx($command);

my $characters = $json->decode($data);



print Dumper($characters);

print "\n";

sub Dumper
{
	if (@_ > 1)
	{
		return $json->encode(\@_);
	}
	else
	{
		return $json->encode($_[0]);
	}
}
