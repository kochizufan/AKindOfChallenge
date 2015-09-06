#!perl

use strict;
use warnings;
use utf8;
use Encode qw(encode_utf8);

use feature qw(switch say);
use XML::RSS::Parser;
use LWP::Simple;

my $url = "http://www3.nhk.or.jp/rss/news/cat0.xml";
my $parser = XML::RSS::Parser->new;
my $xml = get($url);
my $feeds = $parser->parse_string($xml);

foreach my $feed ( $feeds->query('//item') ) { 
    my $title = $feed->query('title');
    say " * " . encode_utf8($title->text_content);
}