package Log;
use strict;
use warnings;

use DateTime;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub protocol {
    my $self = shift;
    my ($method, $path, $protocol) = split(/ /, $self->{req});
    return $protocol;
}

sub method {
    my $self = shift;
    my ($method, $path, $protocol) = split(/ /, $self->{req});
    return $method;
}

sub path {
    my $self = shift;
    my ($method, $path, $protocol) = split(/ /, $self->{req});
    return $path;
}

sub uri {
    my $self = shift;
    my ($method, $path, $protocol) = split(/ /, $self->{req});
    my $host = $self->{host};
    return "http://$host$path";
}

sub time {
    my $self = shift;
    my $dt = DateTime->from_epoch(epoch => $self->{epoch}, time_zone => 'GMT'); # Specifying GMT
    return $dt->strftime('%Y-%m-%dT%H:%M:%S');
}

1;
