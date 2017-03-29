package Waypoint;
use strict; use warnings;

our $VERSION = '0.01';

use Package::Subroutine;

our $ROOT = __PACKAGE__;

sub import {
     my $package = shift;
     my @args = @_;

     while(my ($point,$methods) = splice(@args,0,2)) {
         my $pkg = join('::',$ROOT,$point);
         while(my ($method,$coderef) = each(%$methods)) {
             Package::Subroutine->install($pkg,$method,$coderef);
         }
     }
}

1;

=head1 NAME

Waypoint

=head1 SYNOPSIS

  {
    local $Waypoint::ROOT = 'Kdom4';
    use Waypoint
      Start => {
        player => sub { },
        dungeon => sub { },
        monster => sub { }
      },
      Trap => {
        player => sub { }
      },
      Death => {
        monster => sub { } 
      }
  }

  # later in the app
  $env = Kdom4::Start->environment();

=head1 DESCRIPTION

This module is a pure infrastructure module which only helps with
organizing static methods in separate places. The methods don't need
to be static, but this is the intended purpose.

=head2 C<import>

The default value for C<$Waypoint::ROOT> is "Waypoint".

