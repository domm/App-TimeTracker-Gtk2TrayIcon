#!/opt/perl5.10/bin//perl
use 5.010;
use strict;
use warnings;

# ABSTRACT: run App::TimeTracker::Gtk2TrayIcon
# PODNAME: tracker_gtk_trayicon.pl

use App::TimeTracker::Gtk2TrayIcon;
App::TimeTracker::Gtk2TrayIcon->init;
Gtk2->main;

__END__


