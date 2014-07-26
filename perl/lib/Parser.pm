package Parser;
use strict;
use warnings;
use 5.010;

use Log;

my $log_parsing_regex = '^
        host:(?<host>\S+)\t
        user:(?<user>\S+)\t
        epoch:(?<epoch>\d+)\t
        req:(?<req>\S+\s\S+\s\S+)\t
        status:(?<status>\d+)\t
        size:(?<size>\d+)\t
        referer:(?<referer>\S+)
        $';
        
sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub is_parsable_line {
    shift;
    my $_ = shift;
    chomp;

    /$log_parsing_regex/x;
}

sub parse_a_line {
    shift;
    my $_ = shift; # take arguments

    chomp;

    if (/$log_parsing_regex/x) {

	# when parsable
	my %hash_of_log = (
	    'host'    => $+{host},
	    'user'    => $+{user},
	    'epoch'   => $+{epoch},
	    'req'     => $+{req},
	    'status'  => $+{status},
	    'size'    => $+{size},
	    'referer' => $+{referer} 
	    );

	# eliminate keys for omitted value
	while (my ($key, $_) = each %hash_of_log) {
	    if (/^-$/) {delete $hash_of_log{$key};}
	}

	return Log->new(%hash_of_log);

    } else {
	# when non-parsable
	die "invalid input: $_";
    }
}

sub parse {
    my $self = shift;

    # read log file
    open my $LOGFILE, '<', $self->{filename} or die $!;
    my @lines_of_log = <$LOGFILE>;
    close $LOGFILE;

    my @array_parsed_log = [];
    
    # choose only parsable lines
    my $parsable_lines_of_log = grep is_parsable_line, @lines_of_log;
    # parse each line as Log
    my $array_parsed_log = map parse_a_line, $parsable_lines_of_log;
    
    return $array_parsed_log;
}


1;
