package Log;
use strict;
use warnings;

use Parser;
use Visualizer;

# LTSV Visualize script

print 'ARGV0: ' . $ARGV[0] . "\n";
my $parser = Parser->new(filename => $ARGV[0]);
my $visualizer = Visualizer->new(logs => $parser->parse());

$visualizer->meantime_for_path();
