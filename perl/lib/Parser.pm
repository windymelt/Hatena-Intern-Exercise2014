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
    my @logs = ();
    # read log file
    open my $LOGFILE, '<', $self->{filename} or die $!;
    while (defined ($_ = <$LOGFILE>)){
      # choose only parsable lines
      (! /^(?!\s)$/) || next;
      chomp;
      # split line separated by TAB
      push @logs, Log->new(map { split m{:(?!//)} } grep { !/\S+:-$/ } split /\t/);
    }
    close $LOGFILE;
    \@logs;
  }


1;
