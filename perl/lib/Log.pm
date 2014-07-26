package Log;
use strict;
use warnings;

use DateTime;

sub new {
    my ($class, %args) = @_;

    my ($method, $path, $protocol) = split(/ /, $args{req});
    $args{method} = $method;
    $args{path} = $path;
    $args{protocol} = $protocol;

    return bless \%args, $class;
}

sub protocol {
    my $self = shift;
    return $self->{protocol};
}

sub method {
    my $self = shift;
    return $self->{method};
}

sub path {
    my $self = shift;
    return $self->{path};
}

sub uri {
    my $self = shift;
    my $host = $self->{host};
    my $path = $self->{path};
    return "http://$host$path";
}

sub time {
    my $self = shift;
    my $dt = DateTime->from_epoch(epoch => $self->{epoch}, time_zone => 'Asia/Tokyo'); # Specifying JST
    return $dt->strftime('%Y-%m-%dT%H:%M:%S');
}

1;
