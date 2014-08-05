use strict;
use warnings;

use Test::More;

use_ok 'Visualizer';

my $visualizer = Visualizer->new();

is $visualizer->average(1,2,3,4,5,6,7,8,9,10), (1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10) / 10, 'average';
is $visualizer->average(reverse (1,2,3,4,5,6,7,8,9,10)), (1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10) / 10, 'average, reversed';

is $visualizer->mean(1,2,3,4,5,6,7,8,9), 5, 'mean in odd';
is $visualizer->mean(reverse (1,2,3,4,5,6,7,8,9)), 5, 'mean in odd, reversed';
is $visualizer->mean(1,2,3,4,5,6,7,8,9,10), 5.5, 'mean in even';
is $visualizer->mean(reverse (1,2,3,4,5,6,7,8,9,10)), 5.5, 'mean in even, reversed';

done_testing();
