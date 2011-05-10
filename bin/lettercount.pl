#!/usr/bin/perl -w
#

open (THEFILE, $ARGV[0]);

my $holdTerminator = $/;
undef $/;
my $buf = <THEFILE>;
my $letter2;
my $letter;
foreach $letter3 ('','a'..'z'){

  foreach $letter2 ('','a'..'z') {
      
      foreach $letter ('a'..'z') {
	$pattern = $letter3.$letter2.$letter;
	$used{$pattern}++;
	next if ($used{$pattern}>1);
	@matches = ($buf =~ /$pattern/gi);
	
	if(scalar(@matches))
	  {print "$pattern : ", scalar(@matches), "\n";}
      }
    }
}
close(THEFILE);
