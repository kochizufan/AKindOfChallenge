#!perl

use strict;
use warnings;

use feature qw(switch say);

# 配列インプット
my $file = $ARGV[0];
open my $in, "<", $file or die "ファイルが見つかりません";
my $input_line = <$in>;
chomp ($input_line);
my @inputs = split(/\s/,$input_line); 
close $in;

#処理用バッファ
my @buffer;

for (my $i = 0; $i < @inputs; $i++) {
    push @buffer, [$i,$inputs[$i]];
}
my @result = sort { $b->[1] <=> $b->[1] } @buffer;

for my $index (0..2) {
    say $result[$index]->[0] . " -> " . $result[$index]->[1];
}
