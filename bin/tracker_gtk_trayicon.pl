#!/opt/perl5.10/bin//perl
use 5.010;
use strict;
use warnings;

# ABSTRACT: run App::TimeTracker::Gtk2TrayIcon
# PODNAME: tracker_gtk_trayicon.pl

use App::TimeTracker::Gtk2TrayIcon;
App::TimeTracker::Gtk2TrayIcon->init('run');

__END__

=head1 SYNOPSIS

  ~$ tracker_gtk_trayicon.pl &

=head1 DESCRIPTION

Adds a small app to your system tray that shows your working status as
reported by C<App::TimeTracker>.

A green light is shown if you're working, a red light if your idling.
If you hover your mouse over the icon, the project (and tags) you're
currently working on will be displayed.

This script currently neither forks nor puts itself into the
background. The best way (IMO) to start it is via a line in your
F<.xinitrc> (or whatever system your window manager uses to
automatically startup apps).

=head1 OPTIONS AND CONFIGURATION

Currently none.

=head1 SEE ALSO

L<App::TimeTracker>

