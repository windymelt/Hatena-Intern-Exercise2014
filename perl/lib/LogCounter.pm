package LogCounter;
use strict;
use warnings;

sub new {
    my ($class, $logs) = @_;
    return bless { logs => $logs }, $class;
};

sub group_by_user {
    my $ref_logs_arr = shift()->{logs};
    my %user_grouped_logs;

    foreach my $log (@$ref_logs_arr) {
      if ($log->{user} eq '') {
	my $log_array = $user_grouped_logs{guest};
	push(@$log_array, ($log));
	$user_grouped_logs{guest} = $log_array;
      } else {
	my $log_array = $user_grouped_logs{$log->{user}};
	push(@$log_array, ($log));
	$user_grouped_logs{$log->{user}} = $log_array;
      }
    }
    return \%user_grouped_logs;
  }

sub count_error {
  my $ref_logs_arr = shift()->{logs};
  grep { $_->{status} =~ /5\d\d/; } @$ref_logs_arr;
}

1;
