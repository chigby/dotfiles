#!/usr/pkg/bin/perl -w
#

sub scramble {
  my $word = shift;
  my @letters = ($word =~ m/[A-Za-z]/g);
#  print @letters;
  #my @letters = split(//, $word);
  my $length = $#letters + 1;
if($length > 3)
  {
  @middle = @letters[1 .. $#letters-1];
  @vowels = (join("", @middle) =~ m/([aeiou])/ig);
  @cons = (join("", @middle) =~ m/([bcdfghjklmnpqrstvwxyz])/ig);
  @vowels = sort(@vowels);
  @cons = sort(@cons);
  $scr = $letters[0] . join("", @vowels) . join("", @cons) . $letters[$#letters];
  my $letters = join("", @letters);
  $word =~ s/${letters}/${scr}/g;
  $word;
}
else
  {
    $word;
}
}

open (THEFILE, $ARGV[0]);

my $holdTerminator = $/;
undef $/;
my $buf = <THEFILE>;

@words = split(/(\s+)/, $buf);

foreach (@words) {
    $scrambled = scramble($_);
    print $scrambled;
}

close(THEFILE);
