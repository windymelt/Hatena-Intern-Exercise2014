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
      # split line separated by TAB
      my @splited = split /\t/;
      # exclude chunk which has 'MINUS' sign as value e.g. hogehoge:-
      my @filtered = grep { !/\S+:-$/ } @splited;
      # make hash spliting by COLON
      my @hash = map { split m{:(?!//)} } @filtered;

      # this is an element for a line
      Log->new(@hash);
    } @parsable_lines_of_log;
    
    \@logs;
}


1;
