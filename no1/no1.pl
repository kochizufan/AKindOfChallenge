#!perl

use strict;
use warnings;

use feature qw(switch say);

# ピン数インプット
my @throws = @ARGV;
my @scores;
my $index = 0;

foreach my $inning (0..9) {
    my ($score, $next) = score(\@throws,$index);
    $scores[$inning] = $score;
    $index = next;
}
my $total = 0;
$total + $_ for @scores;

say $total;

# X+1投目の倒れた数を得る。足りなければ例外
sub fetch {
    my $throws = shift;
    my $index = shift;
    die "投げた数が足りません" if ($index >= @{$throws});
    my $ret = $throws->[$index];
    die "0-10の数字を入れてください" unless ($index =~ /^(?:10|\d)$/);
    return $ret;
}

# レーンのスコアと次の投目を計算。そのレーンが何投目から始まるかはY+1で指定。
sub score {
    my $throws = shift;
    my $index = shift;
    my $score = $first = fetch($throws,$index);
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