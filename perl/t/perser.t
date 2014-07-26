use strict;
use warnings;

use Test::More;

use_ok 'Parser';

# testing parse_a_line
my $parsed_one = Parser->parse_a_line("host:127.0.0.1	user:frank	epoch:1372694390	req:GET /apache_pb.gif HTTP/1.0	status:200	size:2326	referer:http://www.hatena.ne.jp/");
isa_ok $parsed_one, 'Log';
is $parsed_one->{status}, '200';
is $parsed_one->time, '2013-07-01T15:59:50';
is $parsed_one->{size}, '2326';
is $parsed_one->uri, 'http://127.0.0.1/apache_pb.gif';
is $parsed_one->{user}, 'frank';
is $parsed_one->method, 'GET';
is $parsed_one->{referer}, 'http://www.hatena.ne.jp/';

#honban
my $parser = Parser->new( filename => 'log.ltsv' );
isa_ok $parser, 'Parser';

my $parsed = $parser->parse;

isa_ok $parsed->[0], 'Log';
isa_ok $parsed->[1], 'Log';
isa_ok $parsed->[2], 'Log';

is_deeply $parsed->[0]->to_hash, {
    'status' => '200',
    'time' => '2013-07-01T15:59:50',
    'size' => '2326',
    'uri' => 'http://127.0.0.1/apache_pb.gif',
    'user' => 'frank',
    'method' => 'GET',
    'referer' => 'http://www.hatena.ne.jp/'
};
is_deeply $parsed->[1]->to_hash, {
    'status' => '200',
    'time' => '2013-07-02T19:46:30',
    'size' => '1234',
    'uri' => 'http://127.0.0.1/apache_pb.gif',
    'user' => 'john',
    'method' => 'GET',
    'referer' => 'http://b.hatena.ne.jp/hotentry'
};
is_deeply $parsed->[2]->to_hash, {
    'status' => '503',
    'time' => '2013-07-03T23:33:10',
    'method' => 'GET',
    'referer' => 'http://www.example.com/start.html',
    'size' => '9999',
    'uri' => 'http://127.0.0.1/apache_pb.gif'
};

done_testing();
