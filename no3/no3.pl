#!perl

use strict;
use warnings;

use feature qw(switch say);
use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);
use Crypt::CBC;

my ($source,$destination,$inverse,$key);
$inverse = 0;
$key = "default key";
GetOptions(
    "source|s=s" => \$source,
    "destination|d=s" => \$destination,
    "inverse|i" => \$inverse,
    "key|k:s" => \$key
);

die "元ファイルがありません" unless (-e $source);

# 元ファイル内容読み込み
open my $src_fd,"<",$source;
my $input = '';
while (my $line = <$src_fd>) {
    $input .= $line;
}
close $src_fd;

my $cipher = Crypt::CBC->new( 
    -key    => $key,
    -cipher => 'Blowfish'
);

my $output;
if ($inverse) {
    $output = $cipher->decrypt($input);
} else {
    $output = $cipher->encrypt($input);
}

open my $dst_fd,">",$destination;
print $dst_fd $output;
close $dst_fd;



