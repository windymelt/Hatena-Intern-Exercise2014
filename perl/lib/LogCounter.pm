package LogCounter;
use strict;
use warnings;

sub new {
    my ($class, $logs) = @_;
    return bless { logs => $logs }, $class;
};

sub group_by_user {
  # logs held by this instance
  my $ref_logs_arr = shift()->{logs};
  my %user_grouped_logs;
  
  # process each log one by one
  foreach my $log (@$ref_logs_arr) { push(@{$user_grouped_logs{$log->{user} // 'guest'}}, ($log)); }
  return \%user_grouped_logs;
}

sub count_error {
  my $ref_logs_arr = shift()->{logs};
  # status code 500 - 599 is 'error'
  grep { $_->{status} =~ /5\d\d/; } @$ref_logs_arr;
}

1;
