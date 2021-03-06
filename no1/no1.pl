#!perl

use strict;
use warnings;

use feature qw(switch say);

# ピン数インプット
my $file = $ARGV[0];
open my $in, "<", $file or die "ファイルが見つかりません";
my $throw_num = <$in>;
chomp ($throw_num);
my $throw_line = <$in>;
chomp ($throw_line);
my @throws = split(/\s/,$throw_line); 
close $in;

die "投げた回数があいません" if ($throw_num != @throws);
my @scores;
my $index = 0;

foreach my $inning (0..9) {
    my ($score, $next) = score(\@throws,$index);
    $scores[$inning] = $score;
    $index = $next;
}
my $total = 0;
$total += $_ for @scores;

say $total;

# $index+1投目の倒れた数を得る。足りなければ例外
sub fetch {
    my $throws = shift;
    my $index = shift;
    die "投げた数が足りません" if ($index >= @{$throws});
    my $ret = $throws->[$index];
    die "0-10の数字を入れてください" unless ($ret =~ /^(?:10|\d)$/);
    return $ret;
}

# レーンのスコアと次の投目を計算。そのレーンが何投目から始まるかは$index+1で指定。
sub score {
    my $throws = shift;
    my $index = shift;
    my $score = my $first = fetch($throws,$index);
    $score += fetch($throws,++$index);
    if ($first == 10) {
        $score += fetch($throws,$index+1);
    } else {
        $index++;
        if ($score == 10) {
            $score += fetch($throws,$index);
        }
    }
    return ($score, $index);
}