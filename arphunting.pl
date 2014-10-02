#!/usr/bin/perl -w
use strict;
use Text::Diff;
	
print "Please enter network address: ";
chomp(my $net = <STDIN>);

print "Please enter subnet: ";
chomp(my $netmask = <STDIN>);

my $subnet = $net."/".$netmask;
print $subnet;
	
my $file_new = "arpscan_output.txt";
my $file_old = "arpscan_output2.txt";
	
if(-e $file_new) 
{
    if(!-e $file_old)
    {
      	`mv $file_new $file_old`;
    }
} 
elsif(-e $file_new && -e $file_old)
{
    `rm -rf $file_old`;
    `mv $file_new $file_old`;
}

`sudo arp-scan --interface=wlan0 '$subnet' > $file_new`;


my $diffs = diff $file_new => $file_old;

print $diffs;

