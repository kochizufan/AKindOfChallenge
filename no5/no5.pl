#!perl

use strict;
use warnings;
use utf8;
use Encode qw(utf8_decode);

use feature qw(switch say);
use XML::RSS::Parser;
use LWP::Simple;

my $url = "http://www3.nhk.or.jp/rss/news/cat0.xml";
my $parser = XML::RSS::Parser->new;
my $xml = get($url);
my $feeds = $parser->parse_string($xml);

# use Data::Dumper;
# print Dumper($feeds);

foreach my $feed ( $feeds->query('//item') ) { 
    my $title = $feed->query('title');
    say " * " . utf8_decode($title->text_content);
}