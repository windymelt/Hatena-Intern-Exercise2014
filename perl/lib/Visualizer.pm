package Visualizer;
use strict;
use warnings;
use 5.010;

use DateTime;
use Data::Dumper;
use List::Util qw/min max sum/;
use Term::ANSIColor;

sub new {
  my ($class, %args) = @_;
  return bless \%args, $class;
}

sub meantime_for_path {
  my $self = shift;
  my $maximum_length = 80;
  my $maximum_path_length = 10;
  my @logs = @{$self->{logs}};
  my %access_count = ();
  my $maximum = 0;
  my $minimum = 0;

  foreach my $log (@logs) {
    push @{$access_count{$log->{path}}}, ($log->{reqtime_microsec});
    if($log->{reqtime_microsec} > $maximum){$maximum = $log->{reqtime_microsec};}
    if($minimum == 0 || $log->{reqtime_microsec} < $minimum){$minimum = $log->{reqtime_microsec};}
  }
  #print Dumper(%access_count);
  foreach my $path (sort keys %access_count){
    # allocate for blank space
    my $bar_length = $maximum_length - $maximum_path_length - 2;
    my $path_min = min(@{$access_count{$path}});
    my $path_max = max(@{$access_count{$path}});
    my $from = int(($path_min / $maximum) * $bar_length);
    my $to = int(($path_max / $maximum) * $bar_length);
    my @bar = split //, ('-' x $bar_length);
    foreach($from..($to - 1)){
      when($from){$bar[$_] = '<';}
      when($to - 1){$bar[$_] = '>';}
      default{$bar[$_] = '=';}
    }
    my $avg = int average(@{$access_count{$path}});
    $bar[($avg / $maximum) * $bar_length] = colored('A', 'cyan');
    my $mean = mean(@{$access_count{$path}});
    $bar[($mean / $maximum) * $bar_length] = colored('M', 'green');
    printf "%${maximum_path_length}s %s %s\n", $path, join('', @bar),
      "$path_min - $path_max, " . colored("AVG(int) $avg", 'cyan') . ', ' . colored("MEAN $mean", 'green');
  }
  print "-----visualize status-----\n";
  printf "MIN: %d MAX: %d \n", $minimum, $maximum;
}

sub average {
  my $self = shift;
  my @them = @_;

  sum(@them) / @them;
}

sub mean {
  my $self = shift;
  my @them = sort @_;
  if(@them % 2 == 1){
    # odd
    @them[@them / 2];
  }else{
    #even
    (@them[@them / 2] + @them[@them / 2 + 1]) / 2;
  }
}


1;
