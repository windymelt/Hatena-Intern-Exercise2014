package Parser;
use strict;
use warnings;
use 5.010;

use Data::Dumper;
use Log;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}



sub parse {
    my $self = shift;

    # read log file
    open my $LOGFILE, '<', $self->{filename} or die $!;
    my @lines_of_log = <$LOGFILE>;
    close $LOGFILE;

    # choose only parsable lines
    my @parsable_lines_of_log = grep { /(?!\s)/ } @lines_of_log;
    # parse each line as Log
    my @logs = map {
      chomp;
      my @splited = split /\t/;
      my @filtered = grep {!/\S+:-$/} @splited;
      my @hash = map {split m{:(?!//)}} @filtered;
      Log->new(@hash);
    } @parsable_lines_of_log;
    
    \@logs;
}


1;
